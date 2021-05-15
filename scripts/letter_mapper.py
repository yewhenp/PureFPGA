
LETTERS = {
    'h': [['#', ' ', ' ', ' ', ' '],
          ['#', ' ', ' ', ' ', ' '],
          ['#', ' ', '#', ' ', ' '],
          ['#', '#', ' ', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', ' ', ' ', '#', ' ']],
    'e': [[' ', ' ', ' ', ' ', ' '],
          [' ', '#', '#', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', '#', '#', '#', ' '],
          ['#', ' ', ' ', ' ', ' '],
          [' ', '#', '#', '#', ' ']],
    'l': [['#', ' '],
          ['#', ' '],
          ['#', ' '],
          ['#', ' '],
          ['#', ' '],
          ['#', ' ']],
    'w': [[' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' '],
          ['#', ' ', ' ', ' ', '#', ' '],
          ['#', ' ', '#', ' ', '#', ' '],
          ['#', ' ', '#', ' ', '#', ' '],
          [' ', '#', '#', '#', '#', ' ']],
    'o': [[' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' '],
          [' ', '#', '#', ' ', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          [' ', '#', '#', ' ', ' ']],
    'r': [[' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' '],
          ['#', '#', '#', ' ', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', ' ', ' ', ' ', ' '],
          ['#', ' ', ' ', ' ', ' ']],
    'd': [[' ', ' ', ' ', '#', ' '],
          [' ', ' ', ' ', '#', ' '],
          [' ', '#', '#', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          [' ', '#', '#', '#', ' ']],
    ' ': [[' ', ' '],
          [' ', ' '],
          [' ', ' '],
          [' ', ' '],
          [' ', ' '],
          [' ', ' ']],
    ',': [[' ', ' ', ' '],
          [' ', ' ', ' '],
          [' ', ' ', ' '],
          [' ', ' ', ' '],
          [' ', '#', ' '],
          ['#', ' ', ' ']],
    'a': [[' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' '],
          [' ', '#', '#', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          [' ', '#', '#', '#', ' ']],
    'b': [['#', ' ', ' ', ' ', ' '],
          ['#', ' ', ' ', ' ', ' '],
          ['#', '#', '#', ' ', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', '#', '#', ' ', ' ']],
    'c': [[' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' '],
          ['#', '#', '#', ' '],
          ['#', ' ', ' ', ' '],
          ['#', ' ', ' ', ' '],
          ['#', '#', '#', ' ']],
    'f': [[' ', ' ', ' ', ' '],
          [' ', '#', '#', ' '],
          ['#', ' ', ' ', ' '],
          ['#', '#', ' ', ' '],
          ['#', ' ', ' ', ' '],
          ['#', ' ', ' ', ' ']],
    'A': [[' ', '#', '#', ' '],
          ['#', ' ', '#', ' '],
          ['#', ' ', '#', ' '],
          ['#', '#', '#', ' '],
          ['#', ' ', '#', ' '],
          ['#', ' ', '#', ' ']],
    'P': [['#', '#', ' ', ' '],
          ['#', ' ', '#', ' '],
          ['#', ' ', '#', ' '],
          ['#', '#', ' ', ' '],
          ['#', ' ', ' ', ' '],
          ['#', ' ', ' ', ' ']],
    'S': [['#', '#', '#', ' '],
          ['#', ' ', ' ', ' '],
          ['#', ' ', ' ', ' '],
          ['#', '#', '#', ' '],
          [' ', ' ', '#', ' '],
          ['#', '#', '#', ' ']],
    'U': [['#', ' ', ' ', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          ['#', ' ', ' ', '#', ' '],
          [' ', '#', '#', '#', ' ']],
    'C': [['#', '#', '#', ' '],
          ['#', ' ', ' ', ' '],
          ['#', ' ', ' ', ' '],
          ['#', ' ', ' ', ' '],
          ['#', ' ', ' ', ' '],
          ['#', '#', '#', ' ']]
}

COLORS = {
    0: 65280,
    1: 16774912,
    2: 16757504,
    3: 16711680,
    4: 16732357,
    5: 4607
}

COLORS_LETTERS = {
    'A': 7949971,
    'P': 7949971,
    'S': 7949971,
    'U': 4390716,
    'C': 4390716,
    ' ': 0
}

SCREEN_WIDHT = 1024

def generate_kostyl_white(phrase, mode='h'):
    str_to_write = ''
    for i in range(6):
        temp_str = ''
        temp_str_colors = ''
        if mode == 'm':
            temp_str += ' ' * (i * 2)
        for char in phrase:
            line = LETTERS[char][i]
            line = ''.join(line)
            temp_str += line
            temp_temp_str = ' '.join(line)
        # temp_str += ' ' * (SCREEN_WIDHT - len(temp_str) - (i * 2))
        temp_str += ' ' * (SCREEN_WIDHT - len(temp_str))
        # str_to_write = str_to_write[ : -1 * ]
        # temp_str += '\n'
        if mode == 'm':
            temp_str = temp_str.replace('#', '16777215 ')
            temp_str = temp_str.replace(' ', '0 ')
        str_to_write += temp_str

    with open('letters_repr7.txt', 'w') as filee:
        filee.write(str_to_write)


def generate_kostyl(phrase, mode='h'):
    str_to_write = ''
    for i in range(6):
        temp_str = ''
        temp_str_colors = ''
        if mode == 'm':
            temp_str += ' ' * (i * 2)
        for char in phrase:
            line = LETTERS[char][i]
            line = ''.join(line)
            temp_str += line
            temp_temp_str = ' '.join(line)
        # temp_str += ' ' * (SCREEN_WIDHT - len(temp_str) - (i * 2))
        temp_str += ' ' * (SCREEN_WIDHT - len(temp_str))
        # str_to_write = str_to_write[ : -1 * ]
        # temp_str += '\n'
        if mode == 'm':
            temp_str = temp_str.replace('#', str(COLORS[i]) + ' ')
            temp_str = temp_str.replace(' ', '0 ')
        str_to_write += temp_str

    with open('letters_repr7.txt', 'w') as filee:
        filee.write(str_to_write)


def generate_kostyl_color_buttons(phrase, mode='h'):
    str_to_write = ''
    for i in range(6):
        temp_str = ''
        temp_temp_str = ''
        if mode == 'm':
            temp_str += ' ' * (i * 2)
            temp_temp_str += '0 ' * (i * 2)
        for char in phrase:
            line = LETTERS[char][i]
            line = ''.join(line)
            temp_str += line
            a_line = line.replace('#', str(COLORS_LETTERS[char]) + ' ')
            a_line = a_line.replace(' ', '0 ')
            temp_temp_str += a_line
        # temp_str += ' ' * (SCREEN_WIDHT - len(temp_str) - (i * 2))
        # temp_str += ' ' * (SCREEN_WIDHT - len(temp_str))
        temp_temp_str += '0 ' * (SCREEN_WIDHT - len(temp_str))
        # str_to_write = str_to_write[ : -1 * ]
        # temp_temp_str += '\n'
        if mode == 'm':
            temp_str = temp_str.replace('#', str(COLORS[i]) + ' ')
            temp_str = temp_str.replace(' ', '0 ')
        str_to_write += temp_temp_str

    with open('letters_repr10.txt', 'w') as filee:
        filee.write(str_to_write)




if __name__ == '__main__':
    # generate_kostyl('hello', mode='m')
    generate_kostyl_color_buttons('APPS UCU', mode='m')
