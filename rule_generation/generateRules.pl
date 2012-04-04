#!/usr/bin/perl -w

$id = "[a-zA-Z_][\\w-]*";

# read the skeletons from STDIN
# output is written to STOUT

print "\\rules {\n";

$tac = "";
while (<>) {
  $tac .= $_;
  if ($tac =~ /^(\s*$id\s*{.*};)(.*)$/s) {
    $next = $2;
    
    # so far, only one dynamic relation by <% REL ... %> is supported
    $sk = $1;
    $n = 1;

    # if no directive is found, the taclet is written out unchanged
    unless ($sk =~ /<%.*%>/) {
#      print "$sk\n";
      $tac = $next;
      next;
    }

    # R1
    $ins = "REL"; $sort = "Rel1"; $ar = 1;
    $sv = "  \\schemaVar \\term $sort $ins;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in($1,$ins)/) {
        $sv .= "\n  \\schemaVar \\term Atom $1;";
      }
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    # R2
    $ins = "REL"; $sort = "Rel2"; $ar = 2;
    $sv = "  \\schemaVar \\term $sort $ins;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in($1,$ins)/) {
        $sv .= "\n  \\schemaVar \\term Tuple2 $1;";
      }
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    # R3
    $ins = "REL"; $sort = "Rel3"; $ar = 3;
    $sv = "  \\schemaVar \\term $sort $ins;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in($1,$ins)/) {
        $sv .= "\n  \\schemaVar \\term Tuple3 $1;";
      }
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    # only generate rules with join-sin if membership is involved
    unless ($sk =~ /<%\s*IN\s+$id\s+$id\s*%>/) {
      $tac = $next;
      next;
    }

    # unionN(RN,SN)
    # for ($ar = 1; $ar <= 3; ++$ar) {
    #   $ins = "union${ar}(REL1,REL2)"; $sort = "Rel$ar";
    #   $sv = "  \\schemaVar \\term Rel$ar REL1,REL2;";
    #   $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    #   unless ($tac eq "") {
    #     while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in($1,REL1)/) {
    #       $sv .= "\n  \\schemaVar \\term ". (($ar == 1) ? "Atom" : "Tuple$ar") ." $1;";
    #     }
    #     while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
    #     $tac =~ s/<!SV!>/$sv/ or die;
    #     print "$tac";
    #   }
    #   $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    #   unless ($tac eq "") {
    #     while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in($1,REL2)/) {
    #       $sv .= "\n  \\schemaVar \\term ". (($ar == 1) ? "Atom" : "Tuple$ar") ." $1;";
    #     }
    #     while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
    #     $tac =~ s/<!SV!>/$sv/ or die;
    #     print "$tac";
    #   }
    # }

    # join1x2(sin(a),R2)
    $ins = "join1x2(sin(x),REL)"; $sort = "Rel1"; $ar = 1;
    $sv = "  \\schemaVar \\term Atom x;\n  \\schemaVar \\term Rel2 REL;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in(binary(x,$1),REL)/) {
        $sv .= "\n  \\schemaVar \\term Atom $1;";
      }
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    # join1x3(sin(a),R3)
    $ins = "join1x3(sin(x),REL)"; $sort = "Rel2"; $ar = 2;
    $sv = "  \\schemaVar \\term Atom x;\n  \\schemaVar \\term Rel3 REL;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in(ternary(x,${1}1,${1}2),REL)/) {
        $sv .= "\n  \\schemaVar \\term Atom ${1}1, ${1}2;";
      } 
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/binary(${1}1,${1}2)/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    # join1x2(sin(b),join1x3(sin(a),R3))
    $ins = "join1x2(sin(y),join1x3(sin(x),REL))"; $sort = "Rel1"; $ar = 1;
    $sv = "  \\schemaVar \\term Atom x,y;\n  \\schemaVar \\term Rel3 REL;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in(ternary(x,y,$1),REL)/) {
        $sv .= "\n  \\schemaVar \\term Atom $1;";
      } 
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    # join2x1(R2,sin(a))
    $ins = "join2x1(REL,sin(x))"; $sort = "Rel1"; $ar = 1;
    $sv = "  \\schemaVar \\term Atom x;\n  \\schemaVar \\term Rel2 REL;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in(binary($1,x),REL)/) {
        $sv .= "\n  \\schemaVar \\term Atom $1;";
      }
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    # join3x1(R3,sin(a))
    $ins = "join3x1(REL,sin(x))"; $sort = "Rel2"; $ar = 2;
    $sv = "  \\schemaVar \\term Atom x;\n  \\schemaVar \\term Rel3 REL;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in(ternary(${1}1,${1}2,x),REL)/) {
        $sv .= "\n  \\schemaVar \\term Atom ${1}1, ${1}2;";
      } 
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/binary(${1}1,${1}2)/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    # join2x1(join3x1(R3,sin(a)),sin(b))
    $ins = "join2x1(join3x1(REL,sin(x)),sin(y))"; $sort = "Rel1"; $ar = 1;
    $sv = "  \\schemaVar \\term Atom x,y;\n  \\schemaVar \\term Rel3 REL;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in(ternary($1,y,x),REL)/) {
        $sv .= "\n  \\schemaVar \\term Atom $1;";
      } 
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    # join1x2(sin(a),join3x1(R3,sin(c)))
    $ins = "join1x2(sin(y),join3x1(REL,sin(x)))"; $sort = "Rel1"; $ar = 1;
    $sv = "  \\schemaVar \\term Atom x,y;\n  \\schemaVar \\term Rel3 REL;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in(ternary(y,$1,x),REL)/) {
        $sv .= "\n  \\schemaVar \\term Atom $1;";
      } 
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    # join2x1(join1x3(sin(a),R3),sin(c))
    $ins = "join2x1(join1x3(sin(x),REL),sin(y))"; $sort = "Rel1"; $ar = 1;
    $sv = "  \\schemaVar \\term Atom x,y;\n  \\schemaVar \\term Rel3 REL;";
    $tac = doIt ($sk,$ins,$sort,$ar,$n++);
    unless ($tac eq "") {
      while ($tac =~ s/<%\s*IN\s+($id)\s+($id)\s*%>/in(ternary(x,$1,y),REL)/) {
        $sv .= "\n  \\schemaVar \\term Atom $1;";
      } 
      while ($tac =~ s/<%\s*REFTUP\s+($id)\s*%>/$1/) {}
      $tac =~ s/<!SV!>/$sv/ or die;
      print "$tac";
    }

    $tac = $next;
  }
}

print "}\n";

sub doIt {
    # write head
    my ($sk,$ins,$sort,$ar,$suff) = @_;
    my $tac = "";
    while ($sk =~ /\[!1\s+($id)]/) {
      if ($ar == 1) {
        $sk =~ s/\[!1\s+($id)](.*?)\[\/!1]//s;
      } else {
        $sk =~ s/\[!1\s+($id)](.*?)\[\/!1]/$2/s;     
      }
    }
    $sk =~ /^\s*($id)\s*{(?:\s*?\n+)?(.*)};/s or die;
    $tac .= "$1_$suff \{\n"; # rename taclet
    $tac .= "<!SV!>\n";
    $contents = $2;

    while ($contents =~ s/<%\s*SVREL\s+($id)\s+($id)\s*%>/\\schemaVar \\term Rel$ar $1;/s){};
    while ($contents =~ s/<%\s*SVREL\s+($id)\s+(\d+)\s*%>/\\schemaVar \\term Rel$2 $1;/s){};
    $s = ($ar == 1) ? "Atom" : "Tuple$ar";
    while ($contents =~ s/<%\s*SVTUP\s+($id)\s+($id)\s*%>/\\schemaVar \\term $s $1;/s){};
    while ($contents =~ s/<%\s*REL\s+($id)\s+($id)\s*%>/$ins/) {};
    while ($contents =~ s/<%\s*AR\s+($id)\s*%>/$ar/){};
    while ($contents =~ s/<%\s*REFREL\s+($id)\s*%>/$ins/){};

    # handle explicit arity in REL construct
    while ($contents =~ s/<%\s*REL\s+($id)\s+(\d+)\s*%>/$ins/) {
      return "" unless $2 == $ar;
    }

    $tac .= "$contents";
    $tac .= "};\n";
    return $tac;
}

