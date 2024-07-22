<script>
    import { onMount, getContext, createEventDispatcher } from 'svelte';
    const map = getContext('leaflet-map');
    const marker = getContext('leaflet-marker');

    import L from 'leaflet';
  
    export let miles;
    let circle = null;
    const dispatch = createEventDispatcher();
  
    function drawCircle() {

      if (map && marker) {
          const radius = miles * 1609.34; // Convert miles to meters
  
          // Remove existing circle if present
          if (circle) {
              map.removeLayer(circle);
          }
  
          circle = L.circle(marker.getLatLng(), {
              radius: radius,
              opacity: 0.5,
              fillColor: 'blue',
              fillOpacity: 0.2
          }).addTo(map);
  
          dispatch('circleDrawn', { circle });
      }
    }
  </script>
  
  <form id="plot">
    <input type="number" bind:value={miles} min="0" placeholder="Enter radius in miles" />
    <button on:click={drawCircle}>Draw Circle</button>
  </form>
  
  <style>
    #plot {
      display: flex;
      justify-content: center;
      align-items: flex-end;
      margin: 1rem;
      z-index: 1000;
      background-color: white;
      padding: 1rem;
      border-radius: 0.5rem;
      box-shadow: 0 0 1rem rgba(0, 0, 0, 0.1);
    }
  </style>