from flask_migrate import Migrate
from flask_mail import Mail
from flask_moment import Moment
# from flask_session import Session
from authlib.integrations.flask_client import OAuth
from flask_wtf.csrf import CSRFProtect
from web.models import db, bcrypt, s_manager

# Load environment variables
from dotenv import load_dotenv
load_dotenv()
from os import getenv

# Initialize extensions
# f_session = Session()
mail = Mail()
migrate = Migrate()
moment = Moment()
oauth = OAuth()
csrf = CSRFProtect()

# Determine the environment and set the Redis URL accordingly
if getenv('FLASK_ENV') == 'production':
    redis_url = getenv('REDIS_URL', 'redis://localhost:6379/0')  # Fallback if not set
else:
    redis_url = getenv('REDIS_URL_DEV', 'redis://localhost:6379/0')  # Fallback if not set

# Initialize Redis client
from redis import Redis
redis = Redis.from_url(redis_url)

# from flask_limiter import Limiter
# from flask_limiter.util import get_remote_address
# # Initialize Flask-Limiter with IP-based rate limiting
# limiter = Limiter(
#     key_func=get_remote_address,
#     default_limits=["1 per second", "5 per minute"],  # Allow up to 1 request per second or a burst of 5 in a minute
#     storage_uri=redis_url  # Use the same Redis URL for limiting
# )

def config_app(app, config_name):
    """Configure app settings based on environment."""
    from web.config import app_config
    app.config.from_object(app_config[config_name])

def init_ext(app):
    """Initialize all extensions."""
    db.init_app(app)
    # f_session.init_app(app)
    bcrypt.init_app(app)
    s_manager.init_app(app)
    mail.init_app(app)
    migrate.init_app(app, db)
    moment.init_app(app)
    oauth.init_app(app)
    csrf.init_app(app)

def make_available():
    """Provide application metadata."""
    app_data = {
        'app_name': 'Barman',
        'hype': 'Your Digital Learning Companion.',
        'app_desc': 'Building a future where learning fits seamlessly into your everyday life.',
        'app_location': 'Graceland Estate, Lekki, Lagos, Nigeria.',
        'app_email': 'hi@techa.tech',
        'app_logo': getenv('logo_url'),
        'github_link': 'https://www.github.com/russiantech',
        'whatsapp_link': 'https://chat.whatsapp.com/Ipqr601PAFO6D9lkTd4Lm4',
        'fb_link': 'https://www.facebook.com/Chrisjsmes.fb.co',
        'x_link': 'https://twitter.com/chris_jsmes',
        'instagram_link': 'https://www.instagram.com/chrisjsmz/',
        'linkedin_link': 'www.linkedin.com/in/chrisjsm',
        'dribble_link': 'https://dribbble.com/chrisjsm',
        'youtube_link': 'https://www.facebook.com/russiantech',
        'utchannel_link': 'https://www.youtube.com/@russian_developer',
    }

    return app_data
