export const addResizeObserver = (el: Element, callback: (entry) => void) => {
  const observer = new ResizeObserver(entries => {
    for (let entry of entries) {
      callback(entry)
    }
  })
  observer.observe(el)
}
