const express = require('express');
const axios = require('axios');
const app = express();
const port = 3000; // Choose a port for your server

// Replace these values with your GitHub OAuth App details
const clientId = 'yourClientId';
const clientSecret = 'yourClientSecret';
const redirectUri = 'http://localhost:3000/auth/callback'; // Should match your GitHub OAuth App settings

// Redirect to GitHub for authentication
app.get('/auth', (req, res) => {
  res.redirect(`https://github.com/login/oauth/authorize?client_id=${clientId}&redirect_uri=${redirectUri}`);
});

// GitHub callback to exchange code for access token
app.get('/auth/callback', async (req, res) => {
  const code = req.query.code;

  try {
    const { data } = await axios.post('https://github.com/login/oauth/access_token', {
      client_id: clientId,
      client_secret: clientSecret,
      code: code,
      redirect_uri: redirectUri,
    }, {
      headers: {
        'Accept': 'application/json',
      },
    });

    // Handle the access token (e.g., save it to session or database)
    const accessToken = data.access_token;

    // For demonstration purposes, you may want to redirect to a success page
    res.redirect('https://cotharticren.wixsite.com/dartmeadow/autumn');
  } catch (error) {
    console.error('Error exchanging code for access token:', error);
    res.status(500).send('Error exchanging code for access token');
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
