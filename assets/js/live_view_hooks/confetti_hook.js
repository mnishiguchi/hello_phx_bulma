const defaultOpts = {
  count: window.party.variation.range(30, 60),
  spread: window.party.variation.range(40, 80),
  size: 1.5
}

export default {
  mounted() {
    // Show confetti effect. See https://party.js.org
    this.handleEvent('mn:confetti', (opts = {}) => {
      window.party.confetti(document.querySelector('body'), { ...defaultOpts, ...opts })
    })
  }
}
