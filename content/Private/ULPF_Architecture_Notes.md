# ULPF Architecture & Master Notes (Team Explanations)

*This document contains the complete story, component breakdowns, and architectural explanations of the ULPF system in a mix of English and Hinglish. It is designed to help you explain the system to your teammates and SIH Judges.*

---

## 📖 1. The Story of ULPF (The "Fabric" Architecture)

**The Problem (Humara Villain):**
Ek enterprise mein 5 alag-alag security guards (Firewalls jaise Cisco, Fortinet, Palo Alto) hain. Sab apni alag bhasha (Syslog, CSV, CEF) bolte hain. SIEM (Headquarters) ko samajh nahi aata ki kaun kya bol raha hai. Security engineers ka 70% time sirf in bhashaon ko parse karne mein nikal jata hai.

**The Solution (Humara Hero: ULPF):**
ULPF ek "Universal Translation Machine" hai jo in sabhi bhashaon ko sunkar ek global standard bhasha (**OCSF**) mein convert karti hai. Yeh ek single heavy block (monolith) nahi, balki ek **3-Plane Fabric** hai:
1. **Data Plane:** Jaha se logs fast speed mein parse aur translate hote hain.
2. **Synthesis Plane:** Jaha AI (DeepSeek LLM) naye formats ke liye automatically rules banata hai.
3. **Control Plane:** Aapka React UI (Parser Studio) jahan se sab kuch monitor hota hai.

---

## 🛠️ 2. Component Decisions (Why this, not that)

* **Schema (OCSF 1.9):** 100% vendor-neutral. Elastic (ECS) ya Splunk (CIM) use karte toh vendor lock-in ho jata.
* **Parser (DeepParse Hybrid):** Drain3 deterministic aur fast hai. LLM ko sirf offline mask (regex) banane ke liye rakha hai. Har line par LLM chalate toh system 100x slow ho jata.
* **Queue (Redpanda):** KRaft mode mein single binary chalta hai (no Zookeeper). Kafka laptop par bahut heavy hota hai (3 containers). Redpanda air-gapped demo ke liye best hai.
* **Plugins (WASM):** Sandboxed isolation. Agar Fortinet parser fail hua, toh poora system crash nahi hoga. Bina restart ke 200ms mein parser hot-reload ho jata hai.
* **AI (Ollama + DeepSeek-R1-8B Q4):** Size sirf 3.5GB hai. Bina internet (Air-gapped) local laptop par chalega. GPT-4 API use karna SIH rules ke khilaf hai.
* **Data Lake (ClickHouse + Parquet):** Columnar storage ki wajah se 68% space compress hoti hai. Elasticsearch bahut RAM (JVM) khata hai.
* **Demo Data (Synthetic Forge):** Hardware firewalls demo mein laana possible nahi. Forge 100,000 EPS fake logs generate karta hai taaki hum scale aur AI drift (mutated logs daal kar) prove kar sakein.

---

## 🔍 3. How the 5 Architectures Work

1. **System Context (The Big Picture):** Raw Firewalls ➡️ ULPF Blackbox ➡️ Dual Sink (SIEM + Data Lake).
2. **Component Engine (The Core):** Ingestion ➡️ Redpanda (Queue) ➡️ WASM (Drain3 Parser) ➡️ OCSF Mapper (YAML) ➡️ Integrity Hasher ➡️ Sinks.
3. **Sequence Timeline:** Log aate hi Redpanda "ACK" karta hai (API free ho jati hai). WASM log uthata hai, map karta hai, aur hash banata hai. Fail hua toh AI ko background signal jata hai.
4. **Data Architecture (Zero Data Loss):** JSON mein 3 layers hain: Top (`mapped OCSF`), Middle (`unmapped` dictionary), aur Bottom (`raw_data` aur `raw_hash`). Kuch bhi delete nahi hota.
5. **State Architecture (AI Auto-Heal):** Normal (0% unparsed) ➡️ Anomaly (>5% unparsed for 5m) ➡️ Healing (LUNAR + LLM makes rule) ➡️ Canary UI Test ➡️ Wapas Normal.

---

## 🔒 4. Edge Cases & Handling

* **The < 5% Unmapped Data:** Agar 5% se kam data unmapped mein jata hai, toh AI trigger NAHI hota (to prevent system flapping/CPU waste). Data safely `unmapped` JSON mein save ho jata hai. Analyst Parser Studio UI se 1 line YAML likh kar bina restart kiye isko fix kar sakta hai.
* **Lossless Proof (Rehydration):** Har log ke sath original `raw_data` aur `prev_event` hash chain judti hai. `/rehydrate` API call karne par OCSF log se wapas original raw log banta hai. Agar hash match hua = Zero Data Loss.

---

## 🎬 5. The Executive Summary & Demo Script (From ULPF_SRS2.md)

`ULPF_SRS2.md` ek crisp, punchy executive document hai. Isme specifically "Demo Sequence" defined hai jo judges ke saamne exactly 2 minute mein perform karna hai:

1. **Throughput Prove karein:** Synthetic Forge chalayein (100k EPS without crash).
2. **Lossless Prove karein:** UI mein OCSF log par "Rehydrate" click karke Green Tick (hash match) dikhayein.
3. **Plug & Play Prove karein:** UI se naya `juniper.yaml` upload karein. 500ms mein parser active hoga bina system restart kiye.
4. **AI Auto-Heal Prove karein:** Forge script se jaanboojh kar 2% naya mutated format bhejey. UI mein amber alert dikhega, AI automatically naya rule banayega.
5. **Air-Gapped Prove karein:** Demo shuru hone se pehle laptop ka Wi-Fi physically disable karke dikhayein ki system 100% offline chal raha hai.
