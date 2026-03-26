document.addEventListener("nav", async () => {
  const explorer = document.querySelector(".explorer")
  const explorerContent = explorer?.querySelector(".explorer-content")
  if (!explorer || !explorerContent) return

  // Prevent duplicate rendering across SPA navigations
  if (document.getElementById("brain-mode-filter")) return

  try {
    const basePath = document.documentElement.dataset.basepath ?? ""
    const res = await fetch(`${basePath}/static/index.json`)
    if (!res.ok) return
    const searchData = await res.json()

    const tagCounts: Record<string, number> = {}
    const slugToTags: Record<string, string[]> = {}

    for (const [slug, page] of Object.entries(searchData)) {
      const tags = (page as any).tags || []
      slugToTags[slug] = tags
      for (const tag of tags) {
        tagCounts[tag] = (tagCounts[tag] || 0) + 1
      }
    }

    // Get top 4 tags
    const topTags = Object.entries(tagCounts)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 4)
      .map((entry) => entry[0])

    if (topTags.length === 0) return

    // Create UI
    const filterContainer = document.createElement("div")
    filterContainer.id = "brain-mode-filter"
    filterContainer.innerHTML = `
      <div class="brain-mode-label">Brain Mode 🧠</div>
      <div class="brain-mode-pills"></div>
    `
    
    const pillContainer = filterContainer.querySelector(".brain-mode-pills")!
    let activeTag: string | null = null

    const getSlug = (href: string) => {
      try {
        const url = new URL(href, window.location.origin)
        let path = url.pathname.replace(new RegExp(`^${basePath}/`), "").replace(/^\/|\/$/g, "")
        if (path === "") path = "index"
        return path
      } catch {
        return ""
      }
    }

    const applyFilter = (tag: string | null) => {
      activeTag = tag
      
      pillContainer.querySelectorAll(".pill").forEach((pill) => {
        if (pill.textContent === tag) pill.classList.add("active")
        else pill.classList.remove("active")
      })

      const allFileLinks = explorerContent.querySelectorAll<HTMLAnchorElement>("li:not(:has(.folder-container)) > a")
      const allFolders = explorerContent.querySelectorAll<HTMLLIElement>("li:has(.folder-container)")

      if (!tag) {
        allFileLinks.forEach(a => {
          (a.parentElement as HTMLElement).style.display = ""
        })
        allFolders.forEach(folder => {
          folder.style.display = ""
        })
        return
      }

      allFileLinks.forEach(a => {
        const urlSlug = getSlug(a.href)
        let hasTag = false

        // Check if the search index contains a slug that ends with our URL's route
        for (const [idxSlug, tagsForSlug] of Object.entries(slugToTags)) {
          if ((idxSlug === urlSlug || idxSlug.endsWith(`/${urlSlug}`)) && tagsForSlug.includes(tag)) {
            hasTag = true
            break
          }
        }

        if (hasTag) {
          (a.parentElement as HTMLElement).style.display = ""
        } else {
          (a.parentElement as HTMLElement).style.display = "none"
        }
      })

      allFolders.forEach(folder => {
        const hasVisibleFiles = Array.from(folder.querySelectorAll<HTMLElement>("li:not(:has(.folder-container))")).some(li => li.style.display !== "none")
        folder.style.display = hasVisibleFiles ? "" : "none"
      })
    }

    topTags.forEach(tag => {
      const pill = document.createElement("button")
      pill.className = "pill"
      pill.textContent = tag
      pill.onclick = () => {
        if (activeTag === tag) applyFilter(null)
        else applyFilter(tag)
      }
      pillContainer.appendChild(pill)
    })

    // Insert above the explorer
    explorer.insertBefore(filterContainer, explorer.firstChild)

  } catch (e) {
    console.error("Brain mode failed:", e)
  }
})
