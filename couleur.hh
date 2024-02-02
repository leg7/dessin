#include <cstdint>

class Couleur
{
        uint8_t _r, _g, _b;

        public:
        enum class Nom
        {
                Rouge,
                Vert,
                Bleu,
                Jaune,
                Orange,
                Violet,
                Magenta,
                Cyan,
                Noir,
                Blanc
        };

        Couleur(): _r(0), _g(0), _b(0) {};
        Couleur(const uint8_t r, const uint8_t g, const uint8_t b): _r(r), _g(g), _b(b) {};
        Couleur(Nom n);
};
