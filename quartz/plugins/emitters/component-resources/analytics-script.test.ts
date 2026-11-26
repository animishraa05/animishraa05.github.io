import assert from 'node:assert/strict'
import test from 'node:test'
import { googleAnalyticsScript } from './analytics-script'

test('GA4 script loads gtag with the configured measurement ID', () => {
  const script = googleAnalyticsScript('G-0XNMKWCW0G')

  assert.match(script, /gtag\/js\?id=G-0XNMKWCW0G/)
  assert.match(script, /gtag\('config', 'G-0XNMKWCW0G', \{ send_page_view: false \}\)/)
})

test('GA4 script sends one page view on load and one on SPA navigation', () => {
  const script = googleAnalyticsScript('G-0XNMKWCW0G')

  assert.equal((script.match(/gtag\('event', 'page_view'/g) ?? []).length, 2)
  assert.match(script, /addEventListener\('nav'/)
  assert.match(script, /page_location: location\.href/)
})
