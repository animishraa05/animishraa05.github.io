import {
  QuartzComponent,
  QuartzComponentConstructor,
  QuartzComponentProps,
} from '../types/component'
import { classNames } from '../util/lang'
import { FullSlug, resolveRelative } from '../util/path'
import style from './styles/nav.scss'

interface NavLink {
  label: string
  slug: FullSlug
}

// Only destinations that actually exist in content/. A link to a page that is
// not committed yet renders a 404 in the header, which is worse than no link.
const links: NavLink[] = [
  { label: 'writing', slug: 'wiki' as FullSlug },
  { label: 'backend', slug: 'backend' as FullSlug },
  { label: 'ml', slug: 'ml' as FullSlug },
  { label: 'watchlist', slug: 'watchlist-hub' as FullSlug },
]

export default (() => {
  const Nav: QuartzComponent = ({ displayClass, fileData }: QuartzComponentProps) => {
    const current = (fileData.slug ?? '') as FullSlug

    return (
      <nav class={classNames(displayClass, 'nav')} aria-label="Main">
        <ul>
          {links.map(({ label, slug }) => (
            <li key={slug}>
              <a
                class="internal"
                href={resolveRelative(current, slug)}
                data-slug={slug}
                data-no-popover="true"
                aria-current={current === slug ? 'page' : undefined}
              >
                {label}
              </a>
            </li>
          ))}
        </ul>
      </nav>
    )
  }

  Nav.css = style

  return Nav
}) satisfies QuartzComponentConstructor
