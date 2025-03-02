<script>
	import { T, useTask, useThrelte } from '@threlte/core';
	import { Float, Grid, HTML, interactivity, Text3DGeometry } from '@threlte/extras';

	import { RoundedPlaneGeometry } from './PlaneGeometry';
	import Computer from '$lib/models/Computer.svelte';
	import { Vector3, ShaderMaterial, Raycaster, PlaneGeometry, Mesh, Vector2 } from 'three';
	import { onMount } from 'svelte';
	import { Spring } from 'svelte/motion';

	interactivity();

	const { dom, camera } = useThrelte();

	let point = new Spring(
		{
			x: 0,
			y: 0
		},
		{
			stiffness: 0.02,
			damping: 0.06
		}
	);

	let mousePoint = new Vector2();
	let mousePosition = new Vector3();
	let backgroundRef;

	onMount(() => {
		const raycaster = new Raycaster();

		const planeGeo = new PlaneGeometry(45, 45);
		const mesh = new Mesh(planeGeo);
		mesh.position.z = -8.0;

		dom.addEventListener('pointermove', (e) => {
			point.target = {
				x: (e.clientX / window.innerWidth) * 2.0 - 1,
				y: (e.clientY / window.innerHeight) * 2.0 - 1
			};

			raycaster.setFromCamera(point.current, $camera);
			const intersects = raycaster.intersectObject(mesh);
			mousePosition = intersects[0]?.point;
			mousePoint = new Vector2(
				(mousePosition.x / 16.0 + 1.0) * 0.5,
				(1 - (mousePosition.y * 1.08) / 16.0) * 0.5
			);
		});

		dom.addEventListener('pointerleave', (e) => {
			point.target = { x: 0, y: 0 };
		});
	});

	let rotationY = 0.0;
	let rotationX = 0.0;

	// the _process function in Godot.
	useTask((delta) => {
		const dist = 5.5;

		// console.log(dom);
		let pointX = new Vector3(point.current.x, 0, dist);
		let pointY = new Vector3(0, point.current.y, dist);

		let desiredDirectionX = pointX.normalize();
		let directionX = new Vector3(-1, 0, 0);
		let dirCos = desiredDirectionX.dot(directionX);

		let desiredDirectionY = pointY.normalize();
		let directionY = new Vector3(0, 1, 0);
		let dirSin = desiredDirectionY.dot(directionY);

		rotationY = Math.acos(dirCos) - Math.PI / 2 - 0.06;
		rotationX = Math.asin(dirSin) + 0.2;
	});

	let cameraPosition = new Spring(
		{
			x: 0,
			y: -1,
			z: 25
		},
		{
			stiffness: 0.02,
			damping: 0.75
		}
	);

	import gridFragment from '../shaders/gridShader/fragment.glsl?raw';
	import gridVertex from '../shaders/gridShader/vertex.glsl?raw';
	import ComputerScreen from './ComputerScreen.svelte';
</script>

<T.DirectionalLight
	intensity={2}
	rotation={[-1.4146, 0, 0]}
	position={[0, 4.5, 10.5]}
	target.position={[0.4, 10, -4.0]}
	color="#ffffff"
/>
<T.AmbientLight intensity={2.3} position={[0, 0.8, 0]} />

<T.PerspectiveCamera
	position={[0, cameraPosition.current.y, cameraPosition.current.z]}
	makeDefault
	fov={50}
></T.PerspectiveCamera>
<T.Mesh position={[0, -1, -8.0]} bind:this={backgroundRef}>
	<T.PlaneGeometry args={[45, 45]} />
	<T.ShaderMaterial
		fragmentShader={gridFragment}
		vertexShader={gridVertex}
		uniforms={{ mousePoint: { value: 0 } }}
		uniforms.mousePoint.value={mousePoint}
	/>
</T.Mesh>

<T.Group rotation.y={rotationY}>
	<T.Group rotation.x={rotationX}>
		<Float position.z={-0.8} floatingRange={[-0.12, 0.08]} speed={6.0}>
			<Computer />
			<HTML
				rotation={[-0.18, 0.35, 0.02]}
				position={[1.02, 1.8, 3.14]}
				transform
				occlude="blending"
				geometry={new RoundedPlaneGeometry(4.8, 3.6, 0)}
			>
				<div
					role="none"
					class="screen"
					onmouseenter={() => {
						cameraPosition.target = { x: 0, y: 0, z: 21 };
					}}
					onmouseleave={() => {
						cameraPosition.target = { x: 0, y: -1, z: 25 };
					}}
				>
					<ComputerScreen />
				</div>
			</HTML>
		</Float>
	</T.Group>
</T.Group>

<Float floatingRange={[-0.1, 0.08]} speed={4.0}>
	<T.Mesh position={[3.4, 4.4, 4.4]} material.color="#000000">
		<T.PlaneGeometry args={[8.8, 2.4]} />
		<T.Group position={[-3.7, -0.6, 0.1]}>
			<T.Mesh>
				<Text3DGeometry
					text={'DRAFT 1'}
					font={'/fonts/Montserrat-Bold.json'}
					curveSegments={30}
					bevelEnabled={false}
					depth={0}
					size={1.2}
				/>
				<T.MeshBasicMaterial color="#ffffff" />
			</T.Mesh>
		</T.Group>
	</T.Mesh>
</Float>

<Float floatingRange={[-0.1, 0.08]} speed={4.0}>
	<T.Mesh position={[-3.5, -4.0279, -2.4912]} material.color="#000000">
		<T.PlaneGeometry args={[11.5, 3.5]} />
		<T.Group position={[-4.8, -0.65, 0.1]}>
			<T.Mesh>
				<Text3DGeometry
					text={'2-25-2025'}
					font={'/fonts/Montserrat-Bold.json'}
					bevelEnabled={false}
					curveSegments={30}
					depth={0}
					size={1.4}
				/>
				<T.MeshBasicMaterial color="#ffffff" />
			</T.Mesh>
		</T.Group>
	</T.Mesh>
</Float>

<style>
	.screen {
		position: relative;
		left: 8px;
		width: 200px;
		height: 150px;

		background-color: rgb(59, 92, 62);
	}
</style>
