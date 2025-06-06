const variants = ["summer", "spring", "fall", "winter", "unthemed"];

applyTheme("summer");

// variant selector listeners
variants.forEach((variant) => {
  const btn = document.querySelectorAll(
    `#variant-selector > #${variant}`,
  ) as NodeListOf<HTMLButtonElement>;
  btn.forEach((btn) => {
    btn.addEventListener("click", () => {
      applyTheme(variant);
    });
  });
});

function applyTheme(theme: string) {
  document.body.className = theme;
  // reset active class
  document.querySelectorAll("#variant-selector > button").forEach((btn) => {
    btn.classList.remove("active");
  });
  // set active button
  document.querySelectorAll(`#variant-selector > #${theme}`)?.forEach((btn) => {
    btn.classList.add("active");
  });
}
