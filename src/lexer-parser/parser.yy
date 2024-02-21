%skeleton "lalr1.cc"
%require "3.0"

%defines
%define api.parser.class { Parser }
%define api.value.type variant
%define parse.assert

%locations

%code requires {
	#include "Driver.h"
	#include "../instructions/Instructions.h"
	#include "../elements/formes/Formes.h"
	#include <iostream>

	class Scanner;
	class Driver;

	struct ProprieteData {
		Forme::TypePropriete type;
		std::string valeur;
	};
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
	#undef	yylex
	#define yylex scanner.yylex

}

%token NL
%token END
%token <int> ENTIER
%token <float> REEL
%token FLECHE

%token <std::string> COULEUR

%token KW_COULEUR
%token KW_ROTATION
%token KW_REMPLISSAGE
%token KW_OPACITE
%token KW_EPAISSEUR

%token CARRE
%token RECTANGLE
%token TRIANGLE
%token CERCLE
%token ELLIPSE
%token LIGNE
%token CHEMIN
%token TEXTE
%token <const char*> STRING

%type <std::unique_ptr<Instruction>> instruction
%type <std::unique_ptr<Declaration>> declaration
%type <std::unique_ptr<AppelFonction>> appelFonction
%type <std::vector<std::shared_ptr<Expression>>> arglist

%type <int> operation
%type <std::unique_ptr<Forme>> proplist_esp
%type <std::unique_ptr<Forme>> proplist_nl
%type <ProprieteData> propriete
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
	 affectation {
		driver.ast.add($$);
	}
	| appelFonction {
		driver.ast.add($$);
	}
	| boucle {
		driver.ast.add($$);
	}
	| branchement {
		driver.ast.add($$);
	}
	| declaration {
		driver.ast.add(std::move($$));
	}


// TODO: Construire forme puis l'ajouter au contexte de l'AST
declaration:
	forme
	| proplist_esp ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| proplist_nl '}' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}

forme:
	CARRE NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Carre>($2, $3, $4);
	}
	| RECTANGLE NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Rectangle>($2, $3, $4, $5, $6, $7, $8, $9);
	}
	| TRIANGLE NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Triangle>($2, $3, $4, $5);
	}
	| CERCLE NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Cercle>($2, $3, $4);
	}
	| ELLIPSE NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Ellipse>($2, $3, $4, $5);
	}
	| LIGNE NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Ligne>($2, $3, $4, $5);
	}
	| CHEMIN chemin_points {
		$$ = $2;
	}
	| TEXTE NUMBER NUMBER STRING STRING {
		$$ = std::make_unique<Texte>($2, $3, $4, $5);
	}

chemin_points:
	chemin_points ',' NUMBER NUMBER  {
		$$ = std::move($1);
		$$->ajoutePoint($3, $4);
	}
	| NUMBER NUMBER {
		$$ = std::make_unique<Chemin>($1, $2);
	}

proplist_esp:
	forme FLECHE propriete {
		$$ = std::move($1);
		$$->setPropriete($3.type, $3.valeur);
	} proplist_esp '&' propriete {
		$$ = std::move($1);
		$$->setPropriete($3.type, $3.valeur);
	}

proplist_nl:
	forme '{' propriete {
		$$ = std::move($1);
		$$->setPropriete($3.type, $3.valeur);
	} proplist_nl NL propriete {
		$$ = std::move($1);
		$$->setPropriete($3.type, $3.valeur);
	}

propriete:
	KW_COULEUR ':' COULEUR {
		$$.type = Forme::TypePropriete::Couleur;
		$$.valeur = $3;
	}
	| KW_ROTATION ':' REEL '°' {
		$$.type = Forme::TypePropriete::Rotation;
		$$.valeur = std::to_string(mod($3, 360));
	}
	| KW_REMPLISSAGE ':' COULEUR {
		$$.type = Forme::TypePropriete::Remplissage;
		$$.valeur = $3;
	}
	| KW_OPACITE ':' REEL '%' {
		$$.type = Forme::TypePropriete::Opacite;
		$$.valeur = std::to_string($3 * .01f);
	}
	| KW_EPAISSEUR ':' REEL {
		$$.type = Forme::TypePropriete::Epaisseur;
		$$.valeur = std::to_string($3);
	}

affectation:
    /*IDENTIFIANT '=' expression {

        std::cout << "Affectation à réaliser" << std::endl;
    }*/

appelFonction:
	IDENTIFIANT '(' ')' {
		$$ = std::make_unique<AppelFonction>(driver.contexteCourant);
	}
	IDENTIFIANT '(' arglist ')' {
		$$ = std::make_unique<AppelFonction>(driver.contexteCourant, $3);
	}
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


operation:
	NUMBER {
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
