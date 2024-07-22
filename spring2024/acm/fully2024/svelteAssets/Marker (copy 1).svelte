<script>
  import { afterUpdate, getContext, onMount, setContext } from 'svelte';
  const map = getContext('leaflet-map');

  import L, { latLng } from 'leaflet';
  let marker;

  setContext('leaflet-marker', marker);
  onMount(() => {
        marker = L.marker(latLng, {dragabble: true}).addTo(map);
        marker.on('dragend', function (event) {
        const { latitude, longitude } = event.target.getLatLng();
        map.panTo(new L.LatLng(latitude, longitude));
     });
    });
    
</script>