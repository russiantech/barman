from threading import Thread
import traceback
from flask import current_app, render_template
from flask_mail import Message
from web.apis.utils.helpers import error_response, success_response
from web.extensions import mail

"""
def send_async_email(app, msg):
    try:
        with app.app_context():
            mail.send(msg)
            print(f'sucess, email sent!')
    except Exception as e:
        print(f'failure in sending email ->{e} |, {app.config["MAIL_USERNAME"]}, {app.config["MAIL_PASSWORD"]} ')

def send_email_former(subject, sender, recipients, text_body, html_body):
    msg = Message(subject, sender=sender, recipients=recipients)
    msg.html = html_body
    msg.body = text_body
    Thread(target=send_async_email, args=(current_app._get_current_object(), msg)).start()

def reset_email(user):
    token = user.generate_token(type='reset')
    send_email(
        ('[Russiantechnologies] . Reset Your Password'),
        sender=current_app.config['MAIL_USERNAME'],
        recipients=[user.email],
        text_body=render_template('email/forgot.txt', user=user, token=token),
        html_body=render_template('email/forgot.html', user=user, token=token)
        )

def verify_email(user):
    token = user.generate_token(exp=86400, type='verify')
    send_email(
        ('[Techa] . Verifications'),
        sender=current_app.config['MAIL_USERNAME'],
        recipients=[user.email],
        text_body=render_template('email/verify.txt', user=user, token=token),
        html_body=render_template('email/verify.html', user=user, token=token)
        )
"""
 
def send_email(subject, sender, recipients, text_body, html_body):
    def send_async_email(app, msg):
        try:
            with app.app_context():
                mail.send(msg)
                return success_response('Email sent successfully')
        except Exception as e:
            traceback.format_exc()
            return error_response(f"{e}")

    msg = Message(subject, sender=sender, recipients=recipients)
    msg.html = html_body
    msg.body = text_body
    Thread(target=send_async_email, args=(current_app._get_current_object(), msg)).start()

def reset_email(user):
    token = user.make_token(token_type="reset_password")
    send_email(
        '[Techa] . Reset Your Password',
        sender="hackers@techa.tech",
        recipients=[user.email],
        text_body=render_template('email/forgot.txt', user=user, token=token),
        html_body=render_template('email/forgot.html', user=user, token=token)
    )

def verify_email(user):
    token = user.make_token(token_type="verify_email")
    send_email(
        '[Techa] . Verify Your Email Address.',
        sender="hackers@techa.tech",
        recipients=[user.email],
        text_body=render_template('email/verify.txt', user=user, token=token),
        html_body=render_template('email/verify.html', user=user, token=token)
    )

def confirm_email(user):
    token = user.make_token(token_type="confirm_email")
    send_email(
        '[Techa] . Confirmations',
        sender="hackers@techa.tech",
        recipients=[user.email],
        text_body=render_template('email/verify.txt', user=user, token=token),
        html_body=render_template('email/verify.html', user=user, token=token)
    )



