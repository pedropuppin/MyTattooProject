import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="quotation-subscription"
export default class extends Controller {
  static values = { quotationId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "QuotationChannel", id: this.quotationIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
    setTimeout(() => {
      window.scrollTo({top: document.body.scrollHeight, behavior: "smooth"});
      console.warn("warn");
    }, 10);
    console.log("iaeee");
  }

  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    window.scrollTo({top: document.body.scrollHeight, behavior: "smooth"});
  }

  resetForm(event) {
    event.target.reset();
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom");
    this.channel.unsubscribe();
  }
}
