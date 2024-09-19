# Write code that takes a list of values and returns a string that lists each value and its type in a formatted manner. 
# Use f-strings for formatting.

def lista_wartosci_i_typow(wartosci):
    wyniki = []
    for numer, wartosc in enumerate(wartosci, start=1):
        nazwa_typu = type(wartosc).__name__
        
        if isinstance(wartosc, str):
            sformatowana_wartosc = repr(wartosc)
        else:
            sformatowana_wartosc = str(wartosc)

        tekst = f"{numer}. Wartość: {sformatowana_wartosc}, Typ: {nazwa_typu}"
        wyniki.append(tekst)
        
    return "\n".join(wyniki)

przykladowa_lista = [42, "Bayer", 3.14, True, [1, 2, 3], {"a": 1}, None]
wynik = lista_wartosci_i_typow(przykladowa_lista)

print(wynik)
