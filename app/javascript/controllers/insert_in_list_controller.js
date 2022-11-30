import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ["comments", "form"]

  connect() {
    console.log(this.element)
    console.log(this.commentsTarget)
    console.log(this.formTarget)
  }

  send(event) {
    event.preventDefault()

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      if (data.inserted_item) {
        this.#insertCommentAndScrollDown(data.inserted_item)
      }
      this.formTarget.outerHTML = data.form
    })
}

  #insertCommentAndScrollDown(data) {
    this.commentsTarget.insertAdjacentHTML("afterbegin", data)
    this.commentsTarget.scrollTo({top: this.commentsTarget.scrollHeight, behavior: "smooth"});
  }
}
