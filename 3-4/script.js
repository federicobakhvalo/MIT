class LanguageProgress {
  constructor(attribute_name, passed) {
    this.selector = document.querySelector(`[data-language=${attribute_name}]`);
    this.passed = passed;
  }

  getLevel() {
    if (this.passed <= 3) return "bad";
    if (this.passed <= 7) return "medium";
    return "good";
  }
  generate_Array() {
    return [
      ...new Array(this.passed).fill(true),
      ...new Array(10 - this.passed).fill(false),
    ];
  }
  sleep(mili_secs) {
    return new Promise((resolve) => setTimeout(resolve, mili_secs));
  }
  async renderStepByStep(globalDelay = 50) {
    if (!this.selector) return;

    this.selector.innerHTML = "";

    const progressArray = this.generate_Array();

    for (let i = 0; i < progressArray.length; i++) {
      const div = document.createElement("div");
      div.className = `language-box ${progressArray[i] ? "t" : "f"}`;
      div.setAttribute("level", this.getLevel());

      this.selector.appendChild(div);

      await this.sleep(globalDelay);
    }
  }
}

document.addEventListener("DOMContentLoaded", () => {
  const langs = {
    russian: 10,
    english: 6,
    espanol: 2,
  };

  for (const [lang, passed] of Object.entries(langs)) {
    const progress = new LanguageProgress(lang, passed);
    console.log(progress.renderStepByStep(40));
  }
});
