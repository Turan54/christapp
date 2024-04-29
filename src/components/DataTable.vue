<template>
  <div>
    <h1>Artikeldaten</h1>
    <table>
      <thead>
        <tr>
          <th>Artikel ID</th>
          <th>Attribute</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="article in articles" :key="article.id">
          <td>{{ article.articleId }}</td>
          <td>
            <ul>
              <li v-for="attr in filteredAttributes(article.attributes.$values)" :key="attr.articleAttributeId">
                {{ attr.key }}: {{ attr.value }} ({{ attr.language || 'n/a' }}) - {{ attr.label }}
              </li>
            </ul>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'DataTable',
  data() {
    return {
      articles: [],
      allowedKeys: ['MRK', 'MAT', 'MAT2', 'MAT3', 'LEG', 'LEG2', 'LEG3', 'KOLL', 'WRG_2', 'WHG_2', 'ZIEL']
    };
  },
  mounted() {
    this.fetchData();
  },
  methods: {
    fetchData() {
      axios.get('https://localhost:7119/api/Articles/GetArticles')
        .then(response => {
          this.articles = response.data.$values; // Stelle sicher, dass dieser Pfad korrekt ist
        })
        .catch(error => {
          console.error('Es gab einen Fehler beim Abrufen der Daten:', error);
        });
    },
    filteredAttributes(attributes) {
      return attributes.filter(attr => this.allowedKeys.includes(attr.key));
    }
  }
}
</script>

<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  border: 1px solid #ccc;
  padding: 8px;
  text-align: left;
}

th {
  background-color: #eee;
}
</style>
