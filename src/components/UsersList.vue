<template>
    <div>
        <table class="users">
            <tr>
                <th>Name</th>
                <th>Family</th>
                <th>Created Time</th>
            </tr>

            <tr :id="user.id" v-for="user in users" @click="showOptions(user)">
                <td>{{ user.name }}</td>
                <td>{{ user.family }}</td>
                <td>{{ user.createdTime }}</td>
            </tr>

        </table>
        <button @click="isOpen = true">Add Name</button>
    </div>

    <div class="modal" v-if="isOpen">
        <div class="modal-content">
            <h2>Add Name</h2>
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" v-model="firstName" />
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" v-model="lastName" />
            <button @click="createUser">Save</button>
            <button @click="isOpen = false">Close</button>
        </div>
    </div>

    <!-- choose -->
    <div v-if="selectedUser">
        <h2>Оберіть дію</h2>
        <button @click="editUser">Редагувати</button>
        <button @click="deleteUser">Видалити</button>
    </div>

    <div v-if="editingUser">
        <h2>Редагування користувача</h2>
        <input v-model="editingUser.name" type="text" placeholder="Ім'я" />
        <input v-model="editingUser.family" type="text" placeholder="Прізвище" />
        <button @click="saveUser">Зберегти</button>
    </div>
</template>

<script>

const api = 'https://fa16iqnipg.execute-api.us-east-1.amazonaws.com'
import Vue from 'vue';



export default {
    props: ['users'],
    components: {

    },
    data() {
        return {
            isOpen: false,
            firstName: '',
            lastName: '',
            selectedUser: null,
            editingUser: null
        }
    },

    methods: {
        showOptions(user) {
            this.selectedUser = user;
        },
        editUser() {
            this.editingUser = { ...this.selectedUser };
            this.selectedUser = null;
        },

        createUser: async function () {
            const route = api + '/dev/user';
            const requestOptions = {
                method: "POST",
                body: JSON.stringify({ name: this.firstName, family: this.lastName })
            };
            await fetch(route, requestOptions);
            this.$emit('client-created');
            this.isOpen = false;
        },
        deleteUser: async function () {

            const route = `${api}/dev/user/${this.selectedUser.usersId}`;
            await fetch(route, {
                method: "DELETE",
                headers: {
                    "Host": 'ec2-52-91-166-80.compute-1.amazonaws.com',
                }
            })
            console.log('=>', this.selectedUser.usersId);
            this.selectedUser = null;
            this.$emit('client-created');

        },
        saveUser: async function () {
            const route = `${api}/dev/user/${this.editingUser.usersId}`;
            await fetch(route, {
                method: "PUT",
                body: this.editingUser,
                headers: {
                    "Host": 'ec2-52-91-166-80.compute-1.amazonaws.com',
                }
            })
            console.log('=>', this.editingUser)
            this.editingUser = null;
            this.$emit('client-created');

        }
    },
}
</script>

<style>
.users {
    font-family: Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

.users td,
.users th {
    border: 1px solid #ddd;
    padding: 8px;
}

.users tr:nth-child(even) {
    background-color: #f2f2f2;
}

.users tr:hover {
    background-color: #ddd;
}

.users th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color: #04AA6D;
    color: white;
}

/* modal css */

.modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
}

.modal-content {
    background-color: white;
    padding: 20px;
    border-radius: 4px;
}

/* delete modal */
</style>
