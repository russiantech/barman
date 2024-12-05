from flask import Flask
from web.extensions import config_app, init_ext, make_available
from web.utils.helpers import slugify, categ, find_dept_by_name, calc_percent, is_active
from datetime import datetime
from calendar import month_abbr

def create_app(config_name='development'):
    app = Flask(__name__, instance_relative_config=False)

    try:
        # Configure the app
        config_app(app, config_name)
        init_ext(app)
        app.context_processor(make_available) # make some-data available in the context through-out
        
        # Register Blueprints
        from web.auth.routes import auth
        from web.main.routes import main
        from web.endpoint.routes import endpoint
        from web.errors.handlers import errors
        from web.showcase.routes import showcase_bp
        from web.apis.plans import plan_bp
        from web.apis.pays import pay
        from web.apis.user import user_bp
        from web.apis.apportion import apportion_items_bp
        from web.apis.stats import stats_bp
        from web.apis.sales import sales_bp
        from web.apis.items import items_bp

        app.register_blueprint(auth)
        app.register_blueprint(main)
        app.register_blueprint(endpoint)
        app.register_blueprint(errors)
        app.register_blueprint(showcase_bp)
        app.register_blueprint(plan_bp, url_prefix='/api')
        app.register_blueprint(pay, url_prefix='/api')
        app.register_blueprint(user_bp, url_prefix='/api')
        app.register_blueprint(apportion_items_bp, url_prefix='/api')
        app.register_blueprint(stats_bp, url_prefix='/api')
        app.register_blueprint(sales_bp, url_prefix='/api')
        app.register_blueprint(items_bp, url_prefix='/api')

        # Jinja filters and globals
        app.jinja_env.filters.update({
            'slugify': slugify,
            'categ': categ,
            'find_dept_by_name': find_dept_by_name,
        })
        app.jinja_env.globals.update(is_active=is_active)

        @app.context_processor
        def inject_common_data():
            now = datetime.utcnow()
            return {
                'now': now,
                'cyear': now.year % 100,
                'percentage': calc_percent,
                'cweek': now.strftime('%w'),
                'cmonth': now.month,
                'cmonthf': now.strftime('%B'),
                'strptime': datetime.strptime,
                'month_abbr': month_abbr,
            }

        return app
    except Exception as e:
        print(f"Error initializing app: {e}")
        raise
