import requests
import json

def fetch_video_data(category_title):
    url = "https://commons.wikimedia.org/w/api.php"
    params = {
        "action": "query",
        "format": "json",
        "list": "categorymembers",
        "cmtitle": f"Category:{category_title}",
        "cmlimit": 50,  # Adjust as needed
    }

    response = requests.get(url, params=params)
    data = response.json()

    video_data_list = []

    for page in data.get("query", {}).get("categorymembers", []):
        page_id = page.get("pageid")
        video_info = {
            "title": page.get("title"),
            "description": "",  # You may need additional API requests to get description
            "category": category_title,
            "video_url": get_video_url(page_id),
        }

        # Make additional API requests or processing here to fill in description
        # ...

        video_data_list.append(video_info)

    return video_data_list

def get_video_url(page_id):
    url = "https://commons.wikimedia.org/w/api.php"
    params = {
        "action": "query",
        "format": "json",
        "prop": "imageinfo",
        "pageids": page_id,
        "iiprop": "url",
    }

    response = requests.get(url, params=params)
    data = response.json()

    # Extract video URL from the API response
    image_info = data.get("query", {}).get("pages", {}).get(str(page_id), {}).get("imageinfo", [])
    video_url = image_info[0].get("url") if image_info else ""

    return video_url

def save_to_json(data, output_file):
    with open(output_file, "w") as json_file:
        json.dump(data, json_file, indent=2)

if __name__ == "__main__":
    category_title = "Technology"
    video_data = fetch_video_data(category_title)

    # Save the data to a JSON file
    output_file = "video_data.json"
    save_to_json(video_data, output_file)
    print(f"Data saved to {output_file}")