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

	#include "../instructions/Instruction.h"
	#include "../instructions/Affectation.h"
	#include "../instructions/AppelFonction.h"
	#include "../instructions/Boucle.h"
	#include "../instructions/Branchement.h"
	#include "../instructions/Declaration.h"

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

}

%token NL
%token END
%token <double> NOMBRE

%token FLECHE
%token <Couleur::Nom> COULEUR_NOM
%token COULEUR_RGB_START
%token <uint32_t> COULEUR_HEX

%token <std::string> IDENTIFIANT

%token KW_COULEUR
%token KW_ROTATION
%token KW_REMPLISSAGE
%token KW_OPACITE
%token KW_EPAISSEUR
%token KW_TANTQUE
%token KW_SI
%token KW_BOOLEAN
%token KW_ENTIER
%token KW_REEL

%token VL_BOOLEAN

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
%type <std::shared_ptr<Forme>> forme
%type <Forme::Proprietes> proplist_esp
%type <Forme::Proprietes> proplist_nl
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

programme:
	instruction NL programme
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
		driver.ast.add(std::move($$));
	}
	| /* epsilon */

declaration:
	forme ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| forme FLECHE proplist_esp ';' {
		$1->setProprietes($3);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| forme '{' NL proplist_nl '}' {
		$1->setProprietes($4);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| KW_COULEUR IDENTIFIANT '=' couleur ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, $2, std::move($4));
	}
	| KW_BOOLEAN IDENTIFIANT '=' NOMBRE ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, $2, std::make_shared<ElementPrimitif<bool>>($4));
	}
	| KW_ENTIER IDENTIFIANT '=' NOMBRE ';' {
		if (!estEntier($4)) {
			std::cout << $4 << "n'est pas entier!\n";
			exit(69);
		}
		$$ = std::make_unique<Declaration>(driver.contexteCourant, $2, std::make_shared<ElementPrimitif<int>>($4));
	}
	| KW_REEL IDENTIFIANT '=' NOMBRE ';' {
		if (estEntier($4)) {
			std::cout << $4 << "n'est pas flotant!\n";
			exit(69);
		}
		$$ = std::make_unique<Declaration>(driver.contexteCourant, $2, std::make_shared<ElementPrimitif<double>>($4));
	}

forme:
	CARRE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_shared<Carre>($2, $3, $4);
	}
	| RECTANGLE NOMBRE NOMBRE NOMBRE NOMBRE NOMBRE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_shared<Rectangle>($2, $3, $4, $5, $6, $7, $8, $9);
	}
	| TRIANGLE NOMBRE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_shared<Triangle>($2, $3, $4, $5);
	}
	| CERCLE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_shared<Cercle>($2, $3, $4);
	}
	| ELLIPSE NOMBRE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_shared<Ellipse>($2, $3, $4, $5);
	}
	| LIGNE NOMBRE NOMBRE NOMBRE NOMBRE {
		$$ = std::make_shared<Ligne>($2, $3, $4, $5);
	}
	| CHEMIN chemin_points {
		$$ = std::move($2);
	}
	| TEXTE NOMBRE NOMBRE STRING STRING {
		$$ = std::make_shared<Texte>($2, $3, $4, $5);
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
	KW_COULEUR ':' couleur {
		$$.couleur = *$3;
	}
	| KW_REMPLISSAGE ':' couleur {
		$$.remplissage = *$3;
	}
	| KW_OPACITE ':' NOMBRE '%' {
		$$.opacite = $3 * .01f;
	}
	| KW_ROTATION ':' NOMBRE {
		$$.rotation = fmod($3, 360.0f);
	}
	| KW_EPAISSEUR ':' NOMBRE {
		$$.epaisseur = $3;
	}
	| KW_COULEUR ':' couleur '&' proplist_esp {
		$$.couleur = *$3;
	}
	| KW_REMPLISSAGE ':' couleur '&' proplist_esp {
		$$.remplissage = *$3;
	}
	| KW_OPACITE ':' NOMBRE '%' '&' proplist_esp {
		$$.opacite = $3 * .01f;
	}
	| KW_ROTATION ':' NOMBRE '&' proplist_esp {
		$$.rotation = fmod($3, 360.0f);
	}
	| KW_EPAISSEUR ':' NOMBRE '&' proplist_esp {
		$$.epaisseur = $3;
	}

proplist_nl:
	KW_COULEUR ':' couleur NL {
		$$.couleur = *$3;
	}
	| KW_REMPLISSAGE ':' couleur NL {
		$$.remplissage = *$3;
	}
	| KW_OPACITE ':' NOMBRE '%' NL {
		$$.opacite = $3 * .01f;
	}
	| KW_ROTATION ':' NOMBRE NL {
		$$.rotation = fmod($3, 360.0f);
	}
	| KW_EPAISSEUR ':' NOMBRE NL {
		$$.epaisseur = $3;
	}
	| KW_COULEUR ':' couleur NL proplist_nl {
		$$.couleur = *$3;
	}
	| KW_REMPLISSAGE ':' couleur NL proplist_nl {
		$$.remplissage = *$3;
	}
	| KW_OPACITE ':' NOMBRE '%' NL proplist_nl {
		$$.opacite = $3 * .01f;
	}
	| KW_ROTATION ':' NOMBRE NL proplist_nl {
		$$.rotation = fmod($3, 360.0f);
	}
	| KW_EPAISSEUR ':' NOMBRE NL proplist_nl {
		$$.epaisseur = $3;
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
	expression {
		$$ = std::vector<std::shared_ptr<Expression>>(1, std::move($1));
	}
	| arglist ',' expression {
		$$ = std::move($1);
		$$.push_back(std::move($3));
	}

boucle:
	KW_TANTQUE '(' comparaison ')' corps {
		$$ = std::make_unique<Boucle>(driver.contexteCourant, std::move($3), $5);
	}

branchement:
	KW_SI '(' comparaison ')' corps {
		$$ = std::make_unique<Branchement>(driver.contexteCourant, std::move($3), $5);
	}

expression:
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
