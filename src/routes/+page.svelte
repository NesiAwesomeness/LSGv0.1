<script>
	import App from '$lib/components/App.svelte';
</script>

<div class="page">
	<div class="title">
		<span>ITCC</span>
		×
		<span>LSG</span>
	</div>
	<div class="computer">
		<App />
	</div>
	<div class="footer">Designed by Nesi using Three.js</div>
</div>

<style>
	* {
		font-family: Montserrat;
	}

	.page {
		display: grid;
		grid-template-rows: auto 1fr auto;

		justify-items: center;

		width: 100vw;
		height: 100vh;

		background-color: rgba(255, 255, 255, 0);
		overflow: hidden;
		scroll-behavior: none;
	}

	.computer {
		position: relative;
		top: 16px;
		width: 100%;
		height: 100%;
	}

	.title {
		padding: 1rem;
		font-weight: 600;
	}

	.title span {
		padding: 0 0.5rem;
		border: 2px solid black;
		border-radius: 8px;
	}

	.footer {
		margin: 1rem 0 2rem 0;
		padding: 0.125rem 0.5rem;

		font-size: 0.8rem;
		font-weight: 600;

		border: 2px solid black;
		border-radius: 8px;
	}
</style>
