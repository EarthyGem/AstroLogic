from flask import Flask, jsonify, request
from firebase_admin import credentials, firestore, initialize_app
from datetime import datetime

# Initialize Flask app
app = Flask(__name__)

# Initialize Firestore database
cred = credentials.Certificate('/Users/errickwilliams/Documents/AstroLogic1/astrologics-5fcf4-firebase-adminsdk-zxb8h-431fb503ed.json')
initialize_app(cred)
db = firestore.client()

# Define route to handle POST requests
@app.route('/save_event_data', methods=['POST'])
def save_event_data():
    try:
        # Parse request data
        request_data = request.get_json()
        event_data = request_data.get('event_data')
        user_data = request_data.get('user_data')

        # Add timestamp to event data
        event_data['timestamp'] = datetime.now()

        # Save event data to Firestore
        event_ref = db.collection('events').add(event_data)

        # Save user data to Firestore
        user_ref = db.collection('users').add(user_data)

        # Send success response
        return jsonify({'message': 'Event and user data saved successfully'}), 200
    except Exception as e:
        # Send error response
        return jsonify({'error': 'Failed to save event and user data', 'details': str(e)}), 500

# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True)
