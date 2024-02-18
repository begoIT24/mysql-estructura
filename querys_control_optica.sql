USE optica;
/* Llista el total de compres d’un client/a */
SELECT clients.nom, clients.cognom, COUNT(vendes.id_client)
FROM clients
INNER JOIN vendes ON clients.id_client = vendes.id_client
GROUP BY clients.nom, clients.cognom;

/* Llista les diferents ulleres que ha venut un empleat durant un any */
SELECT ulleres.id_ulleres, empleats.nom 
FROM ulleres 
INNER JOIN vendes ON ulleres.id_ulleres = vendes.id_ulleres
INNER JOIN empleats ON empleats.id_empleat = vendes.id_empleat;

/*Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica */
SELECT proveidors.nom FROM proveidors
INNER JOIN ulleres ON proveidors.id_prov = ulleres.id_prov
RIGHT JOIN vendes ON ulleres.id_ulleres = vendes.id_ulleres
GROUP BY proveidors.nom;
