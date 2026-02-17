import { AhpEventBird } from 'ahp-event-bird';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    AhpEventBird.echo({ value: inputValue })
}
