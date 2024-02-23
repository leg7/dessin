%skeleton "lalr1.cc"
%require "3.2"

%defines
%define api.parser.class { Parser }
%define api.value.type variant
%define parse.assert
%language "c++"

%locations

%code requires {
	#include <memory>
	#include <iostream>
	#include <cmath>
	#include <cstdint>
	#include <string>

	#include "../instructions/Instruction.h"
	#include "../instructions/Affectation.h"
	#include "../instructions/AppelFonction.h"
	#include "../instructions/Boucle.h"
	#include "../instructions/Branchement.h"
	#include "../instructions/Declaration.h"

	#include "../elements/Taille.h"
	#include "../elements/Couleur.h"
	#include "../elements/ElementPrimitif.h"
	#include "../elements/formes/Forme.h"
	#include "../elements/formes/Carre.h"
	#include "../elements/formes/Cercle.h"
	#include "../elements/formes/Chemin.h"
	#include "../elements/formes/Ellipse.h"
	#include "../elements/formes/Ligne.h"
	#include "../elements/formes/Rectangle.h"
	#include "../elements/formes/Texte.h"
	#include "../elements/formes/Triangle.h"

	class Scanner;
	class Driver;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
	#include "Driver.h"
	#include "scanner.hh"

	#undef	yylex
	#define yylex scanner.yylex

	bool estEntier(double x) { return ceil(x) == x; }

	struct AttribPropriete { Forme::TypePropriete type; std::string valeur; };
}

%token NL
%token END
%token <double> NOMBRE

%token FLECHE
%token <Couleur::Nom> COULEUR_NOM
%token COULEUR_RGB_START
%token <uint32_t> COULEUR_HEX

%token <std::string> IDENTIFIANT

%token KW_TAILLE
%token KW_COULEUR
%token KW_ROTATION
%token DEGREE
%token KW_REMPLISSAGE
%token KW_OPACITE
%token KW_EPAISSEUR
%token KW_TANTQUE
%token KW_SI
%token KW_BOOLEAN
%token KW_ENTIER
%token KW_REEL

%token CARRE
%token RECTANGLE
%token TRIANGLE
%token CERCLE
%token ELLIPSE
%token LIGNE
%token CHEMIN
%token TEXTE
%token <std::string> STRING

%type <std::shared_ptr<Declaration>> declaration
%type <std::unique_ptr<Forme>> creation_forme
%type <std::unique_ptr<Forme>> forme
%type <std::unique_ptr<Forme>> proplist_esp
%type <std::unique_ptr<Forme>> proplist_nl
%type <AttribPropriete> propriete
%type <std::unique_ptr<Couleur>> couleur

%type <std::unique_ptr<AppelFonction>> appelFonction
%type <std::vector<std::shared_ptr<Instruction>>> arglist

%type <std::unique_ptr<Boucle>> boucle
%type <std::unique_ptr<Expression>> expression
%type <std::unique_ptr<Expression>> comparaison
%type <std::unique_ptr<Instruction>> instruction
%type <std::unique_ptr<Branchement>> branchement
%type <std::vector<std::shared_ptr<Instruction>>> corps
%type <int> operation
%type <std::unique_ptr<Chemin>> chemin_points
%left '-' '+'
%left '*' '/'
%precedence  NEG

%%

espacement:
	NL espacement
	| /* epsilon */

separateur:
	';' | NL espacement

programme:
	instruction separateur programme
	| END NL {
		YYACCEPT;
	}

instruction:
/*
	| appelFonction {
		driver.ast.add($$);
	}
	| boucle {
		driver.ast.add($$);
	}
	| branchement {
		driver.ast.add($$);
	}
	| affectation {
		driver.ast.add(std::move($$));
	}
*/
	declaration {
		driver.ast.add(std::move($1));
	}
	| /* epsilon */

declaration:
	creation_forme {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| IDENTIFIANT '=' creation_forme {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($3), $1);
	}
	| KW_COULEUR IDENTIFIANT '=' couleur ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($4), $2);
	}
	| KW_BOOLEAN IDENTIFIANT '=' NOMBRE ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<ElementPrimitif<bool>>($4), $2);
	}
	| KW_ENTIER IDENTIFIANT '=' NOMBRE ';' {
		if (!estEntier($4)) {
			std::cout << $4 << "n'est pas entier!\n";
			exit(69);
		}
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<ElementPrimitif<int>>($4), $2);
	}
	| KW_REEL IDENTIFIANT '=' NOMBRE ';' {
		if (estEntier($4)) {
			std::cout << $4 << "n'est pas flotant!\n";
			exit(69);
		}
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<ElementPrimitif<double>>($4), $2);
	}
	| KW_TAILLE NOMBRE NOMBRE ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<Taille>($2, $3), "taille");
	}

creation_forme:
	forme {
		$$ = std::move($1);
	}
	| proplist_esp ';' {
		$$ = std::move($1);
	}
	| proplist_nl '}' {
		$$ = std::move($1);
	}

forme:
	CARRE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_unique<Carre>($2, $3, $4);
	}
	| RECTANGLE NOMBRE NOMBRE NOMBRE NOMBRE NOMBRE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_unique<Rectangle>($2, $3, $4, $5, $6, $7, $8, $9);
	}
	| TRIANGLE NOMBRE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_unique<Triangle>($2, $3, $4, $5);
	}
	| CERCLE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_unique<Cercle>($2, $3, $4);
	}
	| ELLIPSE NOMBRE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_unique<Ellipse>($2, $3, $4, $5);
	}
	| LIGNE NOMBRE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_unique<Ligne>($2, $3, $4, $5);
	}
	| CHEMIN chemin_points {
		$$ = std::move($2);
	}
	| TEXTE NOMBRE NOMBRE STRING STRING {
		$$ = std::make_unique<Texte>($2, $3, $4, $5);
	}

chemin_points:
	chemin_points ',' NOMBRE NOMBRE  {
		$$ = std::move($1);
		$$->ajoutePoint($3, $4);
	}
	| NOMBRE NOMBRE {
		$$ = std::make_unique<Chemin>($1, $2);
	}

proplist_esp:
	forme FLECHE propriete {
		$$ = std::move($1);
		$$->setPropriete($3.type, $3.valeur);
	}
	| proplist_esp '&' propriete {
		$$ = std::move($1);
		$$->setPropriete($3.type, $3.valeur);
	}

proplist_nl:
	forme '{' espacement propriete {
		$$ = std::move($1);
		$$->setPropriete($4.type, $4.valeur);
	}
	| proplist_nl separateur propriete {
		$$ = std::move($1);
		$$->setPropriete($3.type, $3.valeur);
	}

propriete:
	KW_COULEUR ':' couleur {
		$$.type = Forme::TypePropriete::Couleur;
		$$.valeur = $3->to_string();
	}
	| KW_REMPLISSAGE ':' couleur {
		$$.type = Forme::TypePropriete::Remplissage;
		$$.valeur = $3->to_string();
	}
	| KW_OPACITE ':' NOMBRE '%' {
		$$.type = Forme::TypePropriete::Opacite;
		$$.valeur = std::to_string($3 * .01f);
	}
	| KW_ROTATION ':' NOMBRE DEGREE {
		$$.valeur = std::to_string(fmod($3, 360.0f));
	}
	| KW_EPAISSEUR ':' NOMBRE {
		$$.valeur = std::to_string($3);
	}

couleur:
	 COULEUR_NOM {
		$$ = std::make_unique<Couleur>($1);
	 }
	 | COULEUR_RGB_START NOMBRE ',' NOMBRE ',' NOMBRE ')' {
	 	$$ = std::make_unique<Couleur>($2, $4, $6);
	 }
	 | COULEUR_HEX {
	 	$$ = std::make_unique<Couleur>($1);
	 }

affectation:
    IDENTIFIANT '=' expression {

    }

expression:

appelFonction:
/*
	IDENTIFIANT '(' ')' {
		$$ = std::make_unique<AppelFonction>(driver.contexteCourant);
	}
	IDENTIFIANT '(' arglist ')' {
		$$ = std::make_unique<AppelFonction>(driver.contexteCourant, $3);
	}
*/

arglist:
/*
	expression {
		$$ = std::vector<std::shared_ptr<Expression>>(1, std::move($1));
	}
	| arglist ',' expression {
		$$ = std::move($1);
		$$.push_back(std::move($3));
	}
*/

boucle:
	KW_TANTQUE '(' comparaison ')' corps {
		$$ = std::make_unique<Boucle>(driver.contexteCourant, std::move($3), $5);
	}

branchement:
	KW_SI '(' comparaison ')' corps {
		$$ = std::make_unique<Branchement>(driver.contexteCourant, std::move($3), $5);
	}

corps:
comparaison:

operation:
	NOMBRE {
		$$ = $1;
	}
	| '(' operation ')' {
		$$ = $2;
	}
	| operation '+' operation {
		$$ = $1 + $3;
	}
	| operation '-' operation {
		$$ = $1 - $3;
	}
	| operation '*' operation {
		$$ = $1 * $3;
	}
	| operation '/' operation {
		$$ = $1 / $3;
	}
	| '-' operation %prec NEG {
		$$ = - $2;
	}

%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
	std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}
