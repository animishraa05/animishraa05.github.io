import {
  QuartzComponent,
  QuartzComponentConstructor,
  QuartzComponentProps,
} from '../types/component'
import { classNames } from '../util/lang'
// @ts-ignore
import script from './scripts/palette.inline'
import style from './styles/palette.scss'

export default (() => {
  const placeholder = 'select an option...'
  const Palette: QuartzComponent = ({ displayClass }: QuartzComponentProps) => (
    <div class={classNames(displayClass, 'palette')}>
      <search id="palette-container">
        <div id="space">
          <div class="input-container">
            <input
              autocomplete="off"
              id="bar"
              name="palette"
              type="text"
              aria-label={placeholder}
              placeholder={placeholder}
            />
          </div>
          <output id="result" />
          <ul id="helper">
            <li>
              <kbd>↑↓</kbd> to navigate
            </li>
            <li>
              <kbd>↵</kbd> to open
            </li>
            <li data-quick-open>
              <kbd>⟶</kbd> to select
            </li>
            <li data-quick-open>
              <kbd>⌘ ⌥ ↵</kbd> to open in a panel
            </li>
            <li data-command style={{ display: 'none' }}>
              <kbd>←→</kbd> to navigate
            </li>
            <li>
              <kbd>esc</kbd> to dismiss
            </li>
          </ul>
        </div>
      </search>
    </div>
  )

  Palette.css = style
  Palette.afterDOMLoaded = script

  return Palette
}) satisfies QuartzComponentConstructor
