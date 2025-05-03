async function getCatFact() {
    try {
      const response = await fetch('https://catfact.ninja/fact');
      const data = await response.json();
      console.log('Cat Fact:', data.fact);
    } catch (error) {
      console.error('Error:', error.message);
    }
  }
  
  getCatFact();
  