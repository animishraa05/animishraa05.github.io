import { Root as MdRoot } from 'mdast'
import { visit } from 'unist-util-visit'
import { QuartzTransformerPlugin } from '../../types/plugin'
import { Graphviz } from '@hpcc-js/wasm/graphviz'

export const GraphvizPlugin: QuartzTransformerPlugin = () => {
  return {
    name: 'Graphviz',
    markdownPlugins() {
      return [
        () => async (tree: MdRoot, _file) => {
          const graphviz = await Graphviz.load()

          visit(tree, 'code', (node) => {
            if (node.lang === 'dot' || node.lang === 'graphviz') {
              try {
                const svg = graphviz.layout(node.value, "svg", "dot")
                node.type = 'html' as 'code'
                node.value = `<div class="graphviz-container" style="display: flex; justify-content: center; margin: 1.5rem 0; overflow-x: auto;">${svg}</div>`
              } catch(e) {
                console.error("Failed to render graphviz block:", e)
              }
            }
          })
        },
      ]
    },
  }
}
