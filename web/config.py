
from os import getenv

class Config:
    
    # Security
    SECRET_KEY = getenv('SECRET_KEY') or 'you-will-never-guess-usssss'

    """Base configuration."""
    TESTING = getenv('TESTING') == True
    DEBUG = getenv('DEBUG') == True
    FLASK_ENV = getenv('FLASK_ENV', 'production')
    WTF_CSRF_ENABLED = False  # Disable CSRF for development/testing

    # Database
    SQLALCHEMY_DATABASE_URI = getenv('DATABASE_URI') or 'sqlite:///'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_POOL_SIZE = 50
    SQLALCHEMY_POOL_TIMEOUT = 30
    SQLALCHEMY_MAX_OVERFLOW = 20

    # Mail configuration
    MAIL_SERVER = getenv('MAIL_SERVER', 'localhost')
    MAIL_PORT = int(getenv('MAIL_PORT', 25))
    MAIL_USE_TLS = getenv('MAIL_USE_TLS') is not None
    MAIL_USERNAME = getenv('MAIL_USERNAME')
    MAIL_PASSWORD = getenv('MAIL_PASSWORD')
    DEFAULT_MAIL_SENDER = getenv('MAIL_USERNAME')
    MAIL_DEBUG = 1

    # Payment
    RAVE_LIVE_SECRET_KEY = getenv('RAVE_LIVE_SECRET_KEY')
    RAVE_TEST_SECRET_KEY = getenv('RAVE_TEST_SECRET_KEY')

    # Miscellaneous
    LOG_TO_STDOUT = getenv('LOG_TO_STDOUT')
    ADMINS = ['jameschristo962@gmail.com', 'chrisjsmez@gmail.com']
    LANGUAGES = ['en', 'es']
    MS_TRANSLATOR_KEY = getenv('MS_TRANSLATOR_KEY')
    ELASTICSEARCH_URL = getenv('ELASTICSEARCH_URL')
    POSTS_PER_PAGE = 25

    # Uploads
    UPLOAD_FOLDER = getenv('UPLOAD_FOLDER', './uploads')
    MAX_CONTENT_PATH = int(getenv('MAX_CONTENT_PATH') or 1024 * 1024)  # Default to 1MB
    ALLOWED_EXTENSIONS = getenv('ALLOWED_EXTENSIONS', 'jpg, jpeg, png, gif, mov, mp4').split(',')

    # Session
    SESSION_TYPE = 'filesystem'
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SECURE = True  # Ensure HTTPS

class DevelopmentConfig(Config):
    """Development-specific configuration."""
    FLASK_ENV = 'development'
    FLASK_DEBUG = True
    FLASK_APP = 'app.py'
    MAIL_DEBUG = True
    DEFAULT_MAIL_SENDER = getenv('DEFAULT_MAIL_SENDER') 
    DEFAULT_MAIL_TOKEN = getenv('mailtrap_token') 
    MAIL_SERVER = getenv('mailtrap_server')
    MAIL_PORT = getenv('mailtrap_port')
    MAIL_USERNAME = getenv('mailtrap_username')
    MAIL_PASSWORD = getenv('mailtrap_password')

class TestingConfig(Config):
    """Testing-specific configuration."""
    TESTING = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///'  # In-memory database for tests


class ProductionConfig(Config):
    DEBUG = False
    TESTING = False
    FLASK_ENV = 'production'
    MAIL_DEBUG = False
    DEFAULT_MAIL_SENDER = getenv('DEFAULT_MAIL_SENDER') 
    MAIL_SERVER = getenv('mail_server')
    MAIL_PORT = getenv('mail_port')
    MAIL_USERNAME = getenv('mail_username')
    MAIL_PASSWORD = getenv('mail_password')

    SQLALCHEMY_ECHO = False
    # Add production-specific settings here
    
    """ prevents Shared Session Cookies #// so that other similar browsers would not have access to same first logged-in user account """
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SECURE = True  # If using HTTPS
    """  SESSION_TYPE = 'redis' # 'filesystem', 'mongodb' etc #//only suitable for small projects """

app_config = {
    'testing': TestingConfig,
    'development': DevelopmentConfig,
    'production': ProductionConfig
}