const bar = document.createElement("div")
bar.id = "reading-progress"
document.body.appendChild(bar)

function updateProgress() {
  const scrollTop = window.scrollY || document.documentElement.scrollTop
  const docHeight = document.documentElement.scrollHeight - document.documentElement.clientHeight
  const progress = docHeight > 0 ? (scrollTop / docHeight) * 100 : 0
  bar.style.width = Math.min(progress, 100) + "%"
}

function setupProgress() {
  // Only show on content pages (not the index/folder pages)
  const isArticle = document.querySelector("article") !== null
  bar.style.opacity = isArticle ? "1" : "0"
  bar.style.width = "0%"
  window.addEventListener("scroll", updateProgress, { passive: true })
}

// Initial setup
document.addEventListener("DOMContentLoaded", setupProgress)

// SPA navigation — Quartz fires "nav" on every page transition
document.addEventListener("nav", () => {
  window.removeEventListener("scroll", updateProgress)
  setupProgress()
})
