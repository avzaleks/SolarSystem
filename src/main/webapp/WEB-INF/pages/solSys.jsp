<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<c:url value="/script/three.min.js" />"></script>
    <script src="<c:url value="/script/FirstPersonControls.js" />"></script>
    <title>SolarSistem</title>
   
    <style>
		html {
		overflow-x: hidden;  
		overflow-y: hidden;
		}
		body{
		background-color:black;
		margin: 0 px;
		}
	</style>	

</head>
<body>
	<audio autoplay>
        <source src="<c:url value="/sound/ennio_morricone.mp3" />">
    </audio>
	 <script>
	   	var camera, scene, render, container;
	    var W,H;
		var t = 0;
		var light;
		
		var forCamera = function (){
			camera.lookAt(look);
		}
		
		window.setTimeout(function() {
			console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			forCamera=function(){}
			}, 5000);
	
		container = document.createElement("div");
		document.body.appendChild(container);
	    
		W = parseInt(document.body.clientWidth);
		H = parseInt(document.body.clientHeight);
			    
		camera = new THREE.PerspectiveCamera(50, W/H, 1, 1000000);
		camera.position.y = 4300;
		camera.position.z = 25000;
		camera.rotation.z = -Math.PI/10;
		
		scene = new THREE.Scene();
		
		light = new THREE.PointLight(0xffffff, 1.9, 25000);
		light.position.set(0, 0, 0);
		light.castShadow = true;
		light.shadowMapWidth = 2048;
		light.shadowMapHight = 2048;
		//scene.add(camera);
		scene.add(light);
		
		//Camera control
		var controls;
		controls = new THREE.FirstPersonControls(camera);
		controls.movementSpeed = 10000;
		controls.lookSpeed = 0.07;
		
		//Creating planets
		var Planet = function (rad, texture){
			this.radius=rad;
			this.texture=texture;
			this.init = function(){
			    var geom = new THREE.SphereGeometry(this.radius, 80, 80);
				var loadTexture = new THREE.ImageUtils.loadTexture(this.texture);
				texture.anisotropy = 24;
				var mat = new THREE.MeshPhongMaterial({map:loadTexture});
				//var mat = new THREE.MeshNormalMaterial();
				var obj = new THREE.Mesh(geom, mat);
				obj.castShadow = true;
				return obj; 
			}
		}
		
		//Stars
		var stars, starsGeom, starsMat;
		starsGeom = new THREE.Geometry();
		starsMat = new THREE.PointCloudMaterial({color:0xbbbbbb, opacity:0.1, size:1, sizeAttenuation:false});
		for(var i=0; i<10000;i++){
			var vertex = new THREE.Vector3();
			vertex.x = Math.random()*2-1;
			vertex.y = Math.random()*2-1;
			vertex.z = Math.random()*2-1;
			vertex.multiplyScalar(6000);
			starsGeom.vertices.push(vertex);
		}
		stars = new THREE.PointCloud(starsGeom, starsMat);
		//-----stars.scale.x = stars.scale.y =  stars.scale.z = 200;
		stars.scale.set(200, 200, 200);
		scene.add(stars);
		
		var stars2, starsGeom2, starsMat2;
		starsGeom2 = new THREE.Geometry();
		starsMat2 = new THREE.PointCloudMaterial({color:0xbbbbbb, opacity:1, size:1, sizeAttenuation:false});
		for(var i=0; i<5000;i++){
			var vertex = new THREE.Vector3();
			vertex.x = Math.random()*2-1;
			vertex.y = Math.random()*2-1;
			vertex.z = Math.random()*2-1;
			vertex.multiplyScalar(6000);
			starsGeom2.vertices.push(vertex);
		}
		stars2 = new THREE.PointCloud(starsGeom2, starsMat2);
		//-----stars.scale.x = stars.scale.y =  stars.scale.z = 200;
		stars2.scale.set(100, 50, 100);
		scene.add(stars2);
				
		//Sun
		var sun, sunGeom, sunMat, texture;
		sunGeom = new THREE.SphereGeometry(2450, 80, 80);
		texture = new THREE.ImageUtils.loadTexture("images/sun_image1.jpg");
		texture.anisotropy = 24;
		sunMat = new THREE.MeshPhongMaterial({map:texture, emissive:0xffffff});
		sun = new THREE.Mesh(sunGeom, sunMat);
		scene.add(sun);
		var look = sun.position
		//Mercury
		var mercury = new Planet(200,"images/merkury_image.jpg").init();
		scene.add(mercury);
				
		//Venus
		var venus = new Planet(250,"images/venus_image.jpg").init();
		scene.add(venus);
		
		//Earth
		var earth, earthGeom, earthMat, textureEarth;
		earthGeom = new THREE.SphereGeometry(500, 20, 20);
		textureEarth = new THREE.ImageUtils.loadTexture("images/earth_image.jpg");
		texture.anisotropy = 24;
		earthMat = new THREE.MeshPhongMaterial({map:textureEarth});
		earth = new THREE.Mesh(earthGeom, earthMat);
		earth.castShadow = true;
		scene.add(earth);
			
		//Mars
		var mars = new Planet(230,"images/mars_image.jpg").init();
		scene.add(mars);
		
		//Jupiter
		var jupiter = new Planet(900, "images/jupiter_image.jpg").init();
		scene.add(jupiter);
		
		//Saturn
		var saturn = new Planet(800, "images/saturn_image.jpg").init();
		scene.add(saturn);
		
		//Ring of Saturn
		var ring, ringGeom, ringMat;
		ringGeom = new THREE.Geometry();
		ringMat = new THREE.PointCloudMaterial({color:0x3A3A3A, opacity:0.3, size:1, sizeAttenuation:false});
		for(var i=0; i<10000;i++){
			var vertex = new THREE.Vector3();
			vertex.x = Math.sin(Math.PI/180*i)*(1600-i/20);
			vertex.y = Math.random()*20;
			vertex.z = Math.cos(Math.PI/180*i)*(1600-i/20);
			//vertex.multiplyScalar(6000);
			ringGeom.vertices.push(vertex);
		}
		ring = new THREE.PointCloud(ringGeom, ringMat);
		ring.castShadow = true;
		scene.add(ring);
		
		//Uran
		var uran = new Planet(150, "images/uran_image.jpg").init();
		scene.add(uran);
		
		//Neptun
		var neptun = new Planet(120, "images/neptun_image.jpg").init();
		scene.add(neptun);
		
		render = new THREE.WebGLRenderer();
		render.setSize(W, H);
	    container.appendChild(render.domElement);	
		animate();
		
	    function animate (){
			
	    	
	    	requestAnimationFrame(animate);
		    controls.update(0.01);
			sun.rotation.y +=0.001; 
			
			mercury.rotation.y +=0.01;
			mercury.position.x = Math.sin(t*0.18)*3000;
			mercury.position.z = Math.cos(t*0.18)*3000;
			
			venus.rotation.y +=0.01;
			venus.position.x = Math.sin(t*0.15)*4500;
			venus.position.z = Math.cos(t*0.15)*4500;
			
			
			earth.rotation.y +=0.01;
			earth.position.x = Math.sin(t*0.1)*6000;
			earth.position.z = Math.cos(t*0.1)*6000;
			
			mars.rotation.y +=0.01;
			mars.position.x = Math.sin(t*0.12)*7000;
			mars.position.z = Math.cos(t*0.12)*7000;
			
			jupiter.rotation.y +=0.02;
			jupiter.position.x = Math.sin(t*0.16)*9000;
			jupiter.position.z = Math.cos(t*0.16)*9000;
			
			saturn.rotation.y +=0.02;
			saturn.position.x = Math.sin(t*0.09)*13000;
			saturn.position.z = Math.cos(t*0.09)*13000;
			
			ring.position.x = saturn.position.x;
			ring.position.z = saturn.position.z;
			
			uran.rotation.y +=0.02;
			uran.position.x = Math.sin(t*0.07)*15000;
			uran.position.z = Math.cos(t*0.07)*15000;
			
			neptun.rotation.y +=0.02;
			neptun.position.x = Math.sin(t*0.07)*18000;
			neptun.position.z = Math.cos(t*0.07)*18000;
			
			
			//camera.lookAt(sun.position);
			//camera.lookAt(look);
			
			forCamera();
			t += Math.PI/180*2;
			render.render(scene, camera);
		}
		</script>
</body>
</html>