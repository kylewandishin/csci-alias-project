token=$(head -n 1 canvas2.key)
cd /home/jovyan/assignment-2-kylewandishin
remote_url=`git remote get-url origin`
cd /home/jovyan/csci-alias-project
api_resp=`curl -H curl "https://canvas.colorado.edu/api/v1/courses/99684/assignment_groups?exclude_assignment_submission_types%5B%5D=wiki_page&exclude_response_fields%5B%5D=description&exclude_response_fields%5B%5D=rubric&include%5B%5D=assignments&include%5B%5D=discussion_topic&include%5B%5D=assessment_requests&override_assignment_dates=true&per_page=50" -H "Authorization: Bearer $token"`
python helper.py "$api_resp" "$remote_url"