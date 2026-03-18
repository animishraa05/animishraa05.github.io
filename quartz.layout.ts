import { PageLayout, SharedLayout } from "./quartz/cfg"
import * as Component from "./quartz/components"

export const sharedPageComponents: SharedLayout = {
  head: Component.Head(),
  header: [],
  afterBody: [
    Component.Comments({
      provider: "giscus",
      options: {
        repo: "animishraa05/animishraa05.github.io",
        repoId: "R_kgDORoJkag",
        category: "Announcements",
        categoryId: "DIC_kwDORoJkas4C4f9J",
        lang: "en",
        inputPosition: "top",
        mapping: "pathname",
        strict: false,
        reactionsEnabled: true,
      },
    }),
  ],
  footer: Component.Footer({
    links: {
      GitHub: "https://github.com/animishraa05",
      LinkedIn: "https://www.linkedin.com/in/animesh-mishra-944287256/",
    },
  }),
}

export const defaultContentPageLayout: PageLayout = {
  beforeBody: [
    Component.ConditionalRender({
      component: Component.Breadcrumbs(),
      condition: (page) => page.fileData.slug !== "index",
    }),
    Component.ArticleTitle(),
    Component.ContentMeta(),
    Component.TagList(),
  ],
  left: [
    Component.PageTitle(),
    Component.MobileOnly(Component.Spacer()),
    Component.Flex({
      components: [
        {
          Component: Component.Search(),
          grow: true,
        },
        { Component: Component.Darkmode() },
        { Component: Component.ReaderMode() },
      ],
    }),
    Component.Explorer({
      title: "explorer",
      folderClickBehavior: "collapse",
      folderDefaultState: "collapsed",
      useSavedState: true,
      sortFn: (a, b) => {
        if ((!a.file && !b.file) || (a.file && b.file)) {
          return a.displayName.localeCompare(b.displayName, undefined, {
            numeric: true,
            sensitivity: "base",
          })
        }
        if (a.file && !b.file) return 1
        return -1
      },
    }),
    Component.RecentNotes({
      title: "recently updated",
      limit: 5,
      showTags: false,
    }),
  ],
  right: [
    Component.Graph({
      localGraph: {
        drag: true,
        zoom: true,
        depth: 2,
        scale: 1.1,
        repulseStrength: 0,
        nodeSize: 4,
        linkDistance: 30,
        fontSize: 0.6,
        opacityScale: 1,
        removeSelfLoops: true,
        showTags: false,
      },
      globalGraph: {
        drag: true,
        zoom: true,
        depth: -1,
        scale: 0.9,
        repulseStrength: 0,
        nodeSize: 4,
        linkDistance: 30,
        fontSize: 0.6,
        opacityScale: 1,
        removeSelfLoops: true,
        showTags: false,
      },
    }),
    Component.DesktopOnly(
      Component.TableOfContents({
        maxDepth: 3,
        minEntries: 3,
        showByDefault: true,
        collapseByDefault: false,
      }),
    ),
    Component.Backlinks(),
  ],
}

export const defaultListPageLayout: PageLayout = {
  beforeBody: [
    Component.Breadcrumbs(),
    Component.ArticleTitle(),
    Component.ContentMeta(),
  ],
  left: [
    Component.PageTitle(),
    Component.MobileOnly(Component.Spacer()),
    Component.Flex({
      components: [
        {
          Component: Component.Search(),
          grow: true,
        },
        { Component: Component.Darkmode() },
      ],
    }),
    Component.Explorer({
      title: "explorer",
      folderClickBehavior: "collapse",
      folderDefaultState: "collapsed",
      useSavedState: true,
    }),
    Component.RecentNotes({
      title: "recently updated",
      limit: 5,
      showTags: false,
    }),
  ],
  right: [],
}