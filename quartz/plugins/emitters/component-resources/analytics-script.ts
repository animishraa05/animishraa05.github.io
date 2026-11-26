/**
 * Build the browser script that loads GA4 and tracks Quartz SPA page views.
 *
 * `send_page_view: false` prevents the gtag config call from sending an initial
 * hit; both the initial view and later `nav` events are sent explicitly so
 * client-side navigation is counted exactly once.
 */
export function googleAnalyticsScript(tagId: string): string {
  return `
    const gtagScript = document.createElement('script')
    gtagScript.src = 'https://www.googletagmanager.com/gtag/js?id=${tagId}'
    gtagScript.defer = true
    gtagScript.onload = () => {
      window.dataLayer = window.dataLayer || []
      function gtag() {
        dataLayer.push(arguments)
      }
      gtag('js', new Date())
      gtag('config', '${tagId}', { send_page_view: false })
      gtag('event', 'page_view', { page_title: document.title, page_location: location.href })
      document.addEventListener('nav', () => {
        gtag('event', 'page_view', { page_title: document.title, page_location: location.href })
      })
    }

    document.head.appendChild(gtagScript)
  `
}
