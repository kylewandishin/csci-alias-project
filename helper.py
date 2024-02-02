import requests

API_URL = "https://canvas.colorado.edu"

# Read API key from file
with open('canvas2.key', 'r') as file:
    API_KEY = file.readline().strip()

# Set up the headers with the Authorization token
headers = {
    'Authorization': f'Bearer {API_KEY}',
}

# Specify course and assignment IDs
c_id = 123  # Replace with your course ID
a_id = 456  # Replace with your assignment ID

# Make a request to get course information
course_url = f"{API_URL}/api/v1/courses/{c_id}"
course_response = requests.get(course_url, headers=headers)

# Check if the course request was successful
if course_response.status_code == 200:
    course_data = course_response.json()
    print(f"Course Information: {course_data['name']}")

    # Make a request to get assignment information
    assignment_url = f"{API_URL}/api/v1/courses/{c_id}/assignments/{a_id}"
    assignment_response = requests.get(assignment_url, headers=headers)

    # Check if the assignment request was successful
    if assignment_response.status_code == 200:
        assignment_data = assignment_response.json()
        print(f"Assignment Information: {assignment_data['name']}")
    else:
        print(f"Failed to retrieve assignment. Status code: {assignment_response.status_code}")
else:
    print(f"Failed to retrieve course. Status code: {course_response.status_code}")
