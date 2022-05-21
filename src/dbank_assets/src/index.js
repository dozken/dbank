import { dbank } from "../../declarations/dbank";

window.addEventListener("load", async () => {
  getBalance();
});

document.querySelector("#btn-top-up").addEventListener("click", async () => {
  disableButtons(true);

  try {
    const amount = Number(document.getElementById("top-up").value.toString());
    await dbank.topUp(amount);
  } finally {
    getBalance();
  }
});

document.querySelector("#btn-withdraw").addEventListener("click", async () => {
  disableButtons(true);

  try {
    const amount = Number(document.getElementById("withdraw").value.toString());
    await dbank.withdraw(amount);
  } catch(e){
    console.log(e)
  }finally {
    getBalance();
  }
});

function disableButtons(disable) {
  document.querySelector("#btn-withdraw").disabled = disable;
  document.querySelector("#btn-top-up").disabled = disable;
}

async function getBalance() {
  try {
    const balance = await dbank.checkBalance();
    document.getElementById("balance").innerText = balance;
  } finally {
    disableButtons(false);
  }
}
