#pragma once

#include <memory>
#include <exception>

#include "contexte.hh"
#include "../formes/forme.hh"

class Expression {
public:
    enum class Type {
        Double,
        Forme
    };

    class Valeur {
    public:
        class Exception: public std::exception {
        public:
            const char * what() const noexcept override { return "Mauvais type de valeur"; }
        };
    public:
        Valeur(double nombre): _type(Type::Double), _nombre(nombre) {}
        Valeur(FormePtr forme): _type(Type::Forme), _forme(forme) {}

        Valeur(Valeur const& autre): _type(autre._type) {
            switch (_type) {
            case Type::Double: _nombre = autre._nombre; break;
            case Type::Forme: _forme = autre._forme; break;
            }
        }

        ~Valeur() {}

        double nombre() const { if (_type == Type::Double) return _nombre; else throw Exception(); }
        FormePtr forme() const { if (_type == Type::Forme) return _forme; else throw Exception(); }

    private:
        Type _type;
        union {
            double _nombre;
            FormePtr _forme;
        };
    };

    virtual Valeur calculer(const Contexte & contexte) const = 0;
};

using ExpressionPtr = std::shared_ptr<Expression>;

