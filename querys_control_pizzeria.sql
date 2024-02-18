USE pizzeria;
/* Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat. */
SELECT productes.nom, botigues.localitat, SUM(`productes comanda`.quantitat) FROM productes
JOIN `productes comanda` ON productes.idProducte = `productes comanda`.idProducte
JOIN comandes ON `productes comanda`.idComanda = comandes.idComanda
JOIN botigues ON comandes.idBotiga = botigues.idBotiga
WHERE  productes.tipus = 'beguda'
GROUP BY localitat;

/* Llista quantes comandes ha efectuat un determinat empleat/da.*/
SELECT empleats.nom, empleats.idEmpleat, COUNT(comandes.idComanda) FROM empleats
JOIN comandes ON comandes.idEmpleat = empleats.idEmpleat
GROUP BY empleats.nom;