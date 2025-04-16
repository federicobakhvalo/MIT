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

class SkillBar {
  constructor(element) {
    this.element = element;
    this.passed = parseInt(element.dataset.passed);
  }

  sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }

  getColor(percent) {
    let r, g;
    if (percent <= 50) {
      r = 255;
      g = Math.round(255 * (percent / 50));
    } else {
      r = Math.round(255 * (1 - (percent - 50) / 50));
      g = 255;
    }
    return `rgb(${r}, ${g}, 0)`;
  }

  async animateFill() {
    if (!this.passed) {
      return;
    }
    this.element.innerHTML = `
     <div class="scroll-process">
		<div class="fill"></div>
	</div>
	<h5 data-typography="small" id="percentage">0%</h5>
    `;

    const fill = this.element.querySelector(".fill");
    const percentage = this.element.querySelector("#percentage");

    for (let i = 0; i <= this.passed; i++) {
      fill.style.width = `${i}%`;
      fill.style.backgroundColor = this.getColor(i);
      percentage.textContent = `${i}%`;
      await this.sleep(10);
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

  const bars = document.querySelectorAll(".linear-progress");
  bars.forEach((container) => {
    const skillBar = new SkillBar(container);
    skillBar.animateFill();
  });
});
