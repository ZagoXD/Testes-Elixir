const apiUrl = 'http://localhost:4000/api';

const messageDiv = document.getElementById('message');

document.getElementById('register-form').addEventListener('submit', async (e) => {
  e.preventDefault();
  const username = document.getElementById('register-username').value;
  const password = document.getElementById('register-password').value;

  try {
    const response = await fetch(`${apiUrl}/register`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ username, password }),
    });

    const result = await response.json();
    messageDiv.textContent = result.message || result.error;
    messageDiv.style.color = response.ok ? 'green' : 'red';
  } catch (error) {
    messageDiv.textContent = 'Error: Unable to connect to the server.';
    messageDiv.style.color = 'red';
  }
});

document.getElementById('login-form').addEventListener('submit', async (e) => {
  e.preventDefault();
  const username = document.getElementById('login-username').value;
  const password = document.getElementById('login-password').value;

  try {
    const response = await fetch(`${apiUrl}/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ username, password }),
    });

    const result = await response.json();
    messageDiv.textContent = result.message || result.error;
    messageDiv.style.color = response.ok ? 'green' : 'red';
  } catch (error) {
    messageDiv.textContent = 'Error: Unable to connect to the server.';
    messageDiv.style.color = 'red';
  }
});
