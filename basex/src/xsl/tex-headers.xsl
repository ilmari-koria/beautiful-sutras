<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="3.0">

  <!-- this stylesheet should not be auto-indented. -->
  <xsl:template name="headers">
    <xsl:param name="title" />
    <xsl:param name="author" />
    <xsl:param name="date" />

    % !TEX encoding = UTF-8
    % !TEX program = lualatex
    
    \documentclass[a5j,12pt]{ltjtbook}
    \usepackage{luatexja}

    <!-- TODO placeholder fancyhdr -->
    \usepackage{fancyhdr}
    \renewcommand{\headrulewidth}{0pt}
    \pagestyle{empty}
    \fancyhf{}

    <!-- TODO page numbering placeholder -->
    \pagenumbering{gobble}

    <!-- TODO paragraphs indents (awesome that this works???) -->
    \setlength{\parindent}{0em}

    <!-- TODO quick hack for setting margins -->
    \usepackage[margin=1cm,nohead,nomarginpar]{geometry}

    <!-- TODO check if there is a better way to load fonts luatexja? -->
    \usepackage{luatexja-fontspec}
    \setmainjfont{NotoSerifCJK-Regular.ttc}

    <!-- TODO title styling placeholder -->
    \usepackage{titlesec}
    % \titleformat{\section}{\fontsize\large\selectfont}

    <!-- TODO line space placeholder -->
    \usepackage{setspace}

    <!-- title metadata -->
    \begin{singlespace}
      \title{\Huge{<xsl:value-of select="$title"/>}}
      \author{<xsl:value-of select="$author"/>}
      \date{<xsl:value-of select="$date"/>}
    \end{singlespace}

  </xsl:template>
</xsl:stylesheet>
