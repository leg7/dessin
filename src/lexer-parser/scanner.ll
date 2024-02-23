%{
#include "scanner.hh"
#include <cstdlib>
#include <cstdio>
#include <string>
#include <iostream>
#include <cstdint>

#define YY_NO_UNISTD_H

using token = yy::Parser::token;

#undef	YY_DECL
#define YY_DECL int Scanner::yylex( yy::Parser::semantic_type * const lval, yy::Parser::location_type *loc )

/* update location on matching */
#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

ENTIER [0-9]+
NOMBRE {ENTIER}?"."?{ENTIER}
HEX "#"[0-9A-Fa-f]{6}

%option c++
%option yyclass="Scanner"
%option noyywrap

%%
%{
	yylval = lval;
%}
fin return token::END;


"+"				 return '+';
"*"				 return '*';
"-"				 return '-';
"/"				 return '/';
"("				 return '(';
")"				 return ')';
"="				 return '=';
","				 return ',';
":"				 return ':';
"&"				 return '&';
";"				 return ';';
"->"			         return token::FLECHE;
"{"				 return '{';
"}"				 return '}';
"%"				 return '%';

(?i:carre)		         return token::CARRE;
(?i:rectangle)	                 return token::RECTANGLE;
(?i:triangle)	                 return token::TRIANGLE;
(?i:cercle)		         return token::CERCLE;
(?i:ellipse)	                 return token::ELLIPSE;
(?i:ligne)		         return token::LIGNE;
(?i:chemin)		         return token::CHEMIN;
(?i:texte)		         return token::TEXTE;

"taille" return token::KW_TAILLE;
"couleur" return token::KW_COULEUR;
"rotation" return token::KW_ROTATION;
"remplissage" return token::KW_REMPLISSAGE;
"opacite" return token::KW_OPACITE;
"epaisseur" return token::KW_EPAISSEUR;
"booleen" return token::KW_BOOLEAN;
"entier" return token::KW_ENTIER;
"reel" return token::KW_REEL;

"true" {
	yylval->build<double>(1);
	return token::NOMBRE;
}
"false" {
	yylval->build<double>(0);
	return token::NOMBRE;
}

"rouge" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Rouge);
	return token::COULEUR_NOM;
}
"vert" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Vert);
	return token::COULEUR_NOM;
}
"bleu" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Bleu);
	return token::COULEUR_NOM;
}
"jaune" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Jaune);
	return token::COULEUR_NOM;
}
"violet" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Violet);
	return token::COULEUR_NOM;
}
"blanc" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Blanc);
	return token::COULEUR_NOM;
}
"noir" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Noir);
	return token::COULEUR_NOM;
}
"orange" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Orange);
	return token::COULEUR_NOM;
}
"magenta" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Magenta);
	return token::COULEUR_NOM;
}

"cyan" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Cyan);
	return token::COULEUR_NOM;
}

"rgb(" {
	return token::COULEUR_RGB_START;
}

{HEX} {
	const char *tmp = YYText();
	yylval->build<uint32_t>(static_cast<uint32_t>(std::strtoul(++tmp, nullptr, 16)));
	return token::COULEUR_HEX;
}

{NOMBRE} {
	yylval->build<double>(std::stod(YYText()));
	return token::NOMBRE;
}

[A-Za-z_][A-Za-z_0-9]* {
	yylval->build<std::string>(std::string(YYText()));
	return token::IDENTIFIANT;
}

"\""[^".]*"\"" {
	yylval->build<std::string>(YYText());
	return token::STRING;
}


"\n" {
	loc->lines();
	return token::NL;
}

%%
