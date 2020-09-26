enum Environments { DEV, QA, PROD }

const AUTH0_DOMAIN = 'dev-hw4-fzx2.us.auth0.com';
const AUTH0_CLIENT_ID = 'qh3UVxULg5he2htEigDXuSQ9HxQjA2Z7';

const AUTH0_REDIRECT_URI = 'com.bogs.weatherapp://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

const AUTH0_DISCOVERY = '$AUTH0_ISSUER/.well-known/openid-configuration';
const WEATHER_KEY = '6fdc3c1bcac1427f2366306c414f6fdc';
const WEATHER_BASE_URL = "https://api.openweathermap.org/data/2.5/";
const WEATHER_PATH = "/weather";
