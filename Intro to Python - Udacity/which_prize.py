def which_prize(points):
    if points<51:
        return 'Congratulations! You have won a wooden rabbit!'
    elif points< 151:
        return 'Oh dear, no prize this time.'
    elif points< 181:
        return 'Congratulations! You have won a wafer-thin-mint!'
    else:
        return 'Congratulations! You have won a penguin!'
