%{
#include "scanner.hh"
#include <cstdlib>
#include <cstdio>
#include <string>
#include <iostream>
#include <cstdint>
#include "../expressions/ExpressionBinaire.h"
#include "../expressions/ExpressionUnaire.h"

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


"("				 return '(';
")"				 return ')';
","				 return ',';
":"				 return ':';
"&"				 return '&';
";"				 return ';';
"->"			       return token::FLECHE;
"{"				 return '{';
"}"				 return '}';
"%"				 return '%';
"°"				 return token::DEGREE;
"."				 return '.';
"["				 return '[';
"]"				 return ']';

(?i:carre)|(?i:carré)	   return token::KW_CARRE;
(?i:rectangle)	         return token::KW_RECTANGLE;
(?i:triangle)	         return token::KW_TRIANGLE;
(?i:cercle)		         return token::KW_CERCLE;
(?i:ellipse)	         return token::KW_ELLIPSE;
(?i:ligne)		         return token::KW_LIGNE;
(?i:chemin)		         return token::KW_CHEMIN;
(?i:texte)		         return token::KW_TEXTE;

(?i:taille) return token::KW_TAILLE;
(?i:couleur) return token::KW_COULEUR;
(?i:rotation) return token::KW_ROTATION;
(?i:remplissage) return token::KW_REMPLISSAGE;
(?i:opacite)|(?i:opacité) return token::KW_OPACITE;
(?i:epaisseur)|(?i:épaisseur) return token::KW_EPAISSEUR;
(?i:positionX) return token::KW_POSX;
(?i:positionY) return token::KW_POSY;
(?i:positionX1) return token::KW_POSX1;
(?i:positionY1) return token::KW_POSY1;
(?i:positionX2) return token::KW_POSX2;
(?i:positionY2) return token::KW_POSY2;
(?i:positionX3) return token::KW_POSX3;
(?i:positionY3) return token::KW_POSY3;
(?i:positionX4) return token::KW_POSX4;
(?i:positionY4) return token::KW_POSY4;

(?i:booleen)|(?i:booléen) return token::KW_BOOLEAN;
(?i:entier) return token::KW_ENTIER;
(?i:reel)|(?i:réel) return token::KW_REEL;


"+" {
	yylval->build<ExpressionBinaire::Operation>(ExpressionBinaire::Operation::ADD);
	return token::OP_ADD;
}
"-" {
	'-';
}
"*" {
	yylval->build<ExpressionBinaire::Operation>(ExpressionBinaire::Operation::MUL);
	return token::OP_MUL;
}
"/" {
	yylval->build<ExpressionBinaire::Operation>(ExpressionBinaire::Operation::DIV);
	return token::OP_DIV;
}
"=" {
	yylval->build<ExpressionBinaire::Operation>(ExpressionBinaire::Operation::EQ);
	return token::OP_EQ;
}
">" {
	yylval->build<ExpressionBinaire::Operation>(ExpressionBinaire::Operation::GT);
	return token::OP_GT;
}
">=" {
	yylval->build<ExpressionBinaire::Operation>(ExpressionBinaire::Operation::GE);
	return token::OP_GE;
}
"<" {
	yylval->build<ExpressionBinaire::Operation>(ExpressionBinaire::Operation::LT);
	return token::OP_LT;
}
"<=" {
	yylval->build<ExpressionBinaire::Operation>(ExpressionBinaire::Operation::LE);
	return token::OP_LE;
}
"&&" {
	yylval->build<ExpressionBinaire::Operation>(ExpressionBinaire::Operation::AND);
	return token::OP_AND;
}
"||" {
	yylval->build<ExpressionBinaire::Operation>(ExpressionBinaire::Operation::OR);
	return token::OP_OR;
}
"!" {
	yylval->build<ExpressionUnaire::Operation>(ExpressionUnaire::Operation::NEG);
	return token::OP_NEG;
}




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
