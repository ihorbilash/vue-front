<template>
  <div id="app"></div>
  <h1>List of Users</h1>
  <hr>
  <UsersList v-bind:users="users" v-on:client-created="getUsers" />
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import UsersList from '@/components/UsersList.vue'

const api = 'https://fa16iqnipg.execute-api.us-east-1.amazonaws.com'

export default defineComponent({
  name: 'app',

  data() {
    return {
      users: [] as any[]
    }
  },
  components: {
    UsersList,
  },
  methods: {

    getUsers: async function () {
      const route = api + '/dev/users';
      const response = await fetch(route);
      const date = await response.json();
      this.users = date.users
      console.log('=>',date)
    },

  },
  mounted() {
    console.log('Component mounted');
     this.getUsers()
  }

})



</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
