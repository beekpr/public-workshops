import time

SLEEP_TIME = 300

if __name__ == '__main__':
    big_list = []
    for i in range(10):
        print(i, len(big_list))
        big_list.extend(list(range(10**i)))
        time.sleep(SLEEP_TIME)
    print(big_list)