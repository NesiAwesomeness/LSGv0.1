<script>
	const dialogue = [
		'Hey! this is my first Threejs Project.',
		'Umm...hello world?',
		'This is what I want to do for the next 3 months.',
		`I guess this is my Introduction Letter.`,
		`Yeah, that's it.`
	];

	// This is a basic timer
	function restFingers(time) {
		return new Promise((resolve) => setTimeout(resolve, time));
	}

	let typed = '';
	let dialogueIndex = 0;
	let typing = false;

	const write = async () => {
		let char = dialogue[dialogueIndex];

		for (let i = 0; i < char.length; i++) {
			typed = char.substring(0, i + 1);
			await restFingers(40);
		}

		if (dialogueIndex === dialogue.length - 1) {
			await restFingers(1000);
			for (let i = char.length; i > 0; i--) {
				typed = char.substring(0, i - 1);
				await restFingers(20);
			}

			dialogueIndex--;
			await restFingers(400);

			write();
		}

		typing = false;
	};

	write();

	async function next() {
		if (typing) {
			return;
		}

		typing = true;

		let char = dialogue[dialogueIndex];
		for (let i = char.length; i > 0; i--) {
			typed = char.substring(0, i - 1);
			await restFingers(20);
		}

		await restFingers(500);
		if (dialogueIndex < dialogue.length - 1) {
			dialogueIndex++;
		}

		write();
	}
</script>

<div class="ui">
	<p>{typed}<span class="head"> ._ </span></p>
	<button onclick={next}>OK...</button>
</div>

<style>
	.ui {
		user-select: none;
		display: grid;
		width: 100%;
		height: 100%;

		grid-template-rows: 1fr 64px;
	}

	p {
		padding: 8px 24px 0;
		font-weight: 500;
		font-size: 1rem;

		color: rgb(133, 255, 92);

		line-height: 1.25rem;
	}

	button {
		font-family: 'Montserrat';
		margin: 0 24px;
		font-weight: 800;

		width: 80px;
		height: 32px;

		background-color: rgb(133, 255, 92);
		color: rgb(59, 92, 62);
		border: none;

		user-select: none;
	}

	button:hover {
		color: rgb(219, 255, 207);
	}

	button:active {
		position: relative;
		top: -2px;
		color: rgb(219, 255, 207);
		background-color: rgb(219, 255, 207);
	}

	.head {
		position: relative;
		left: -8px;
		width: 3px;

		background-color: rgb(133, 255, 92);
		animation: blink 1s steps(1) infinite;
	}

	@keyframes blink {
		0% {
			opacity: 100%;
		}
		50% {
			opacity: 0%;
		}
	}
</style>
