<script>
    import { onDestroy, onMount, setContext } from 'svelte';

    setContext('leaflet-map', {
      getMap: () => node,
    });

    import L from 'leaflet';
    import 'leaflet/dist/leaflet.css';
  
    export const bounds = null;
    export let latitude;
    export let longitude;
    export let zoom;

    let node;
  
    onMount(() => {
      node = document.getElementById('map');
      const map = L.map('map').setView([latitude,longitude], zoom);
      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
      }).addTo(map);
      
    });
  </script>
  
<div class="leaflet-container" bind:this={node}> <slot></slot> </div>

<style>
  :global(.leaflet-container) {
    height: 80%;
    width: 80%;
  }
</style>
